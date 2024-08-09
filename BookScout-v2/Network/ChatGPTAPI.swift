//
//  ChatGPTAPI.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import Foundation
import Combine

class ChatGPTAPI: ObservableObject {
    
    @Published private(set) var historyList = [Message]()
    
    private let systemMessage: Message
    private let temperature: Double
    private let model: String
    
    private let apiKey: String
  
    private let urlSession = URLSession.shared
    private let requestBuilder: URLRequestBuilder
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    init(apiKey: String, model: String = "gpt-3.5-turbo", systemPrompt: String = "Мне нужны рецензии на книги в жанре художественной литературы так же в жанре нон-фикшн. Со следующими правилами: Обязательно укажи название книги на русском и английском. Дай рецензию на книгу в двух предложениях. Выборка книг по самы известным, интерестным, недооцененых. Ты никогда не советуешь одни и те же книги, предлагаешь только новые. Не придумываешь книги. Предлагаешь книги которые существуют. В однои предложеннии расказываешь про автора книги. Стилистика рецензии в форме эссе с доминирующим личным мнением, в котором ты высказывает свое отношение к книге. Отвечаешь на русском языке.", temperature: Double = 0.3) {
        self.apiKey = apiKey
        self.model = model
        self.systemMessage = .init(role: "system", content: systemPrompt)
        self.temperature = temperature
        self.requestBuilder = URLRequestBuilder(apiKey: apiKey)
    }
    
    private func generateMessages(from text: String) -> [Message] {
        var messages = [systemMessage] + historyList + [Message(role: "user", content: text)]
        
        if messages.contentCount > (4000 * 4) {
            _ = historyList.removeFirst()
            messages = generateMessages(from: text)
        }
        return messages
    }
    
    private func jsonBody(text: String, stream: Bool = true) throws -> Data {
        let request = Request(model: model, temperature: temperature,
                              messages: generateMessages(from: text), stream: stream)
        return try JSONEncoder().encode(request)
    }
    
    private func appendToHistoryList(userText: String, responseText: String) {
        self.historyList.append(.init(role: "user", content: userText))
        self.historyList.append(.init(role: "assistant", content: responseText))
    }
    
    private func handleHTTPResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw "Invalid response"
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw "Bad Response: \(httpResponse.statusCode)"
        }
    }
    
    private func handleError(_ result: URLSession.AsyncBytes, httpResponse: HTTPURLResponse) async throws -> String {
        var errorText = ""
        for try await line in result.lines {
            errorText += line
        }

        if let data = errorText.data(using: .utf8), let errorResponse = try? jsonDecoder.decode(ErrorRootResponse.self, from: data).error {
            errorText = "\n\(errorResponse.message)"
        }

        throw "Bad Response: \(httpResponse.statusCode), \(errorText)"
    }
    
    private func sendRequest(_ urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        let (data, response) = try await urlSession.data(for: urlRequest)
        try handleHTTPResponse(response)
        return (data, response)
    }
    
    // Функцию sendMessageStream отправляет асинхронный запрос на сервер API
    func sendMessageStream(text: String) async throws -> AsyncThrowingStream<String, Error> {
        let body = try jsonBody(text: text)
        switch requestBuilder.buildChatCompletionRequest(body: body) {
        case .success(let urlRequest):
            let (result, response) = try await urlSession.bytes(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw "Invalid response"
            }
            
            return AsyncThrowingStream<String, Error> { continuation in
                Task(priority: .userInitiated) { [weak self] in
                    guard let self = self else { return }
                    do {
                        var responseText = ""
                        for try await line in result.lines {
                            if line.hasPrefix("data: "),
                               let data = line.dropFirst(6).data(using: .utf8),
                               let response = try? self.jsonDecoder.decode(StreamCompletionResponse.self, from: data),
                               let text = response.choices.first?.delta.content {
                                responseText += text
                                continuation.yield(text)
                            }
                        }
                        self.appendToHistoryList(userText: text, responseText: responseText)
                        continuation.finish()
                    } catch {
                        continuation.finish(throwing: error)
                    }
                }
            }
        case .failure(let error):
            throw error
        }
    }

    func sendMessage(_ text: String) async throws -> String {
        let body = try jsonBody(text: text, stream: false)
        switch requestBuilder.buildChatCompletionRequest(body: body) {
        case .success(let urlRequest):
            let (data, _) = try await sendRequest(urlRequest)
            let completionResponse = try self.jsonDecoder.decode(CompletionResponse.self, from: data)
            let responseText = completionResponse.choices.first?.message.content ?? ""
            self.appendToHistoryList(userText: text, responseText: responseText)
            return responseText
        case .failure(let error):
            throw error
        }
    }
    
    func deleteHistoryList() {
        self.historyList.removeAll()
    }
    
}

extension String: CustomNSError {
    
    public var errorUserInfo: [String : Any] {
        [
            NSLocalizedDescriptionKey: self
        ]
    }
}

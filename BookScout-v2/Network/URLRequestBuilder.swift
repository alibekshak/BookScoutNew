//
//  URLRequestBuilder.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 24.06.2024.
//

import Foundation

struct URLRequestBuilder {
    private let apiKey: String
    
    private var defaultHeaders: [String: String] {
        [
            APIConstants.Headers.contentType : APIConstants.Headers.jsonContentType,
             APIConstants.Headers.authorization : "Bearer \(apiKey)"
        ]
    }
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func buildRequest(
        url: URL,
        method: HTTPMethod,
        headers: [String: String], 
        body: Data? = nil
    ) -> Result<URLRequest, URLRequestBuilderError> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        urlRequest.httpBody = body
        return .success(urlRequest)
    }
    
    func buildChatCompletionRequest(body: Data?) -> Result<URLRequest, URLRequestBuilderError> {
        guard let url = URL(string: APIConstants.chatCompletionURL) else {
            return .failure(.invalidURL)
        }
        return buildRequest(url: url, method: .post, headers: defaultHeaders, body: body)
    }
}

enum URLRequestBuilderError: Error {
    case invalidURL
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

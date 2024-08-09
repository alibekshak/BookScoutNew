//
//  BaseChatViewModel.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import Foundation

class BaseChatViewModel: ObservableObject {
    @Published var isInteractingWithChatGPT = false
    @Published var messages: [MessageRow] = []
    @Published var favoritesViewModel = FavoritesViewModel.shared
    
    private let userDefaultsKey = "FavoriteItems"
    let userDefaults = UserDefaults.standard
    let api: ChatGPTAPI

    init(api: ChatGPTAPI) {
        self.api = api
        loadFavorites()
    }

    @MainActor
    func send(text: String) async {
        isInteractingWithChatGPT = true
        var streamText = ""
        var messageRow = MessageRow(
            isInteractingWithChatGPT: true,
            sendText: text,
            responseText: streamText,
            responseError: nil)

        self.messages.append(messageRow)

        do {
            let stream = try await api.sendMessageStream(text: text)
            for try await text in stream {
                streamText += text
                messageRow.responseText = streamText.trimmingCharacters(in: .whitespacesAndNewlines)
                self.messages[self.messages.count - 1] = messageRow
            }
        } catch {
            messageRow.responseError = error.localizedDescription
        }

        messageRow.isInteractingWithChatGPT = false
        self.messages[self.messages.count - 1] = messageRow
        isInteractingWithChatGPT = false
    }

    func addToFavorites(text: String) {
        let favoriteItem = FavoriteItem(title: text)
        favoritesViewModel.addToFavorites(item: favoriteItem)

        if let encodedData = try?  JSONEncoder().encode(favoritesViewModel.favoriteItems) {
            userDefaults.set(encodedData, forKey: userDefaultsKey)
        }
    }

    func loadFavorites() {
        if let data = userDefaults.data(forKey: userDefaultsKey),
           let decodedData = try? JSONDecoder().decode([FavoriteItem].self, from: data) {
            favoritesViewModel.favoriteItems = decodedData
        }
    }
}

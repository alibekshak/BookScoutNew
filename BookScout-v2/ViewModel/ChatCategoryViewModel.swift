//
//  ChatCategoryViewModel.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import Foundation

class ChatCategoryViewModel: BaseChatViewModel {
    private let category: String

    init(api: ChatGPTAPI, category: String) {
        self.category = category
        super.init(api: api)
    }

    @MainActor
    func sendTapped() async {
        let text = "Рекомендуй книгу в жанре \(category) ?"
        isInteractingWithChatGPT = true
        await send(text: text)
        isInteractingWithChatGPT = false
    }

    @MainActor
    func retry(message: MessageRow) async {
        guard let index = messages.firstIndex(where: { $0.id == message.id }) else {
            return
        }
        isInteractingWithChatGPT = true
        self.messages.remove(at: index)
        await send(text: message.sendText)
        isInteractingWithChatGPT = false
    }
}

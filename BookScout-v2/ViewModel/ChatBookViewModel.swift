//
//  ChatBookViewModel.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import Foundation

class ChatBookViewModel: BaseChatViewModel {
    
    override init(api: ChatGPTAPI) {
        super.init(api: api)
    }
    
    @MainActor
    func retry(message: MessageRow) async {
        guard let index = messages.firstIndex(where: { $0.id == message.id }) else {
            return
        }
        self.messages.remove(at: index)
        await send(text: message.sendText)
    }
}

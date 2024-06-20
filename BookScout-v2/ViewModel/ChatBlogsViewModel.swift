//
//  ChatBlogsViewModel.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import Foundation

class ChatBlogsViewModel: BaseChatViewModel {
    
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
    
    @MainActor
    func sentTextWorthReading() async {
        let text = "Рекомендуй 3 книг которые, стоит прочитать, напищи интерестный факт об авторах данных книг. Так же расскажи подробно почему ты выбрал эти книги"
        await send(text: text)
    }
    
    @MainActor
    func sentBooksAboutLife() async {
        let text = "Рекамендуй 3 книги о жизнe, кратко дай интерестную информацию об авторе. Так же расскажи подробно почему ты выбрал эти книги"
        await send(text: text)
    }
}

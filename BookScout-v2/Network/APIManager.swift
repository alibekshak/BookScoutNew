//
//  APIManager.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    let api: ChatGPTAPI

    private init() {
        self.api = ChatGPTAPI(apiKey: "PROVIDE_API_KEY")
    }
}

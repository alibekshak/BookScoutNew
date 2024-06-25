//
//  APIConstants.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 25.06.2024.
//

import Foundation

struct APIConstants {
    static let chatCompletionURL = "https://api.openai.com/v1/chat/completions"
    
    struct Headers {
        static let contentType = "Content-Type"
        static let authorization = "Authorization"
        static let jsonContentType = "application/json"
    }
}

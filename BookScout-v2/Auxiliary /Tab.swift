//
//  Tab.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import Foundation

enum Tab: String, CaseIterable, Identifiable {
    case main
    case chat
    case genre
    
    var id: String {
        rawValue
    }
    
    var image: String {
        switch self {
        case .main:
            return "house"
        case .chat:
            return "message"
        case .genre:
            return "books.vertical"
        }
    }
    
}


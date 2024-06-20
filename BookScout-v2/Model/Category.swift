//
//  Category.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import Foundation

struct Category: Identifiable {
    let id = UUID()
    let title: String
    let text: String
    let textSend: String
}

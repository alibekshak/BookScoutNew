//
//  MessageRow.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import Foundation
import SwiftUI

struct MessageRow: Identifiable {
    let id = UUID()
    
    var isInteractingWithChatGPT: Bool
    
    let sendText: String
    
    var responseText: String?
    
    var responseError: String?
    
    var buttons: [String]?
}

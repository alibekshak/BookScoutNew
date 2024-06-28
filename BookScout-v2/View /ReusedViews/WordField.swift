//
//  WordField.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

struct WordField: View {
    
    @Binding var word: String
    
    var placeholder: String
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $word)
                .textFieldStyle(.plain)
                .focused($isFocused)
                .textFieldStyle(PlainTextFieldStyle())
                .font(Font.montserratRegular_18)
                .foregroundColor(.black)
                .placeholder(when: word.isEmpty) {
                    Text(placeholder)
                        .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 2)
        )
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

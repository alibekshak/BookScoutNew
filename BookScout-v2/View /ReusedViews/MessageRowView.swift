//
//  MessageRowView.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

struct MessageRowView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let message: MessageRow
    let retryCallback: (MessageRow) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let text = message.responseText {
                messageRowContent(
                    text: text,
                    bgColor:  CustomColors.backgroundColor,
                    responseError: message.responseError
                )
            }
            Divider()
        }
    }
    
    func messageRowContent(text: String, bgColor: Color, responseError: String? = nil) -> some View {
        VStack(alignment: .leading) {
            Text(text)
                .multilineTextAlignment(.leading)
                .textSelection(.enabled)
            if responseError != nil {
                Text("Мы не можем загрузить информацию прямо сейчас. Пожалуйста, попробуйте еще раз.")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.leading)
                Button("Попробовать еще раз") {
                    retryCallback(message)
                }
                .foregroundColor(.accentColor)
                .padding(.top)
            }
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(bgColor)
        .font(Font.montserratRegular_16)
    }
}



//
//  SelectAuthorFiction.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

struct SelectAuthorFiction: View {
    
    @State private var author = ""
    
    @FocusState var isWordFieldFocused: Bool
    
    @StateObject var chatBookViewModel = ChatBookViewModel(api: APIManager.shared.api)
    
    var body: some View {
        ZStack {
            CustomColors.backgroundColor
                .ignoresSafeArea()
            VStack {
                navigationBar
                VStack(spacing: 60) {
                    WordField(word: $author, placeholder: "Харуки Мураками", isFocused: _isWordFieldFocused)
                    textWarning
                }
                Spacer()
                ButtonFind(chatBookViewModel: chatBookViewModel, sendType: .selectAutor, selectedAuthor: author)
                    .padding(.bottom)
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            isWordFieldFocused = true
        }
    }
    
    var navigationBar: some View {
        HStack {
            Chevron()
            Spacer()
            Text("Имя автора")
                .foregroundColor(Color.black)
                .font(Font.montserratSemiBold_24)
            Spacer()
        }
        .padding(.bottom, 30)
    }
    
    var textWarning: some View {
            Text("Иногда искусственный интеллект неправильно переводит книги на русский язык, поэтому рекомендуется использовать англоязычное название книги")
                .foregroundColor(Color.black.opacity(0.6))
                .font(Font.montserratRegular_18)
                .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SelectAuthorFiction_Previews: PreviewProvider {
    static var previews: some View {
        SelectAuthorFiction(chatBookViewModel: ChatBookViewModel(api: ChatGPTAPI(apiKey: "")))
    }
}


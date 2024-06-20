//
//  ButtonFind.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

enum SendType {
    case sameBook
    case selectAutor
}

struct ButtonFind: View {
    
    @StateObject var chatBookViewModel: ChatBookViewModel
    
    @State var sendType: SendType
    @State var isChatBookViewPresent = false
    
    var title: String = "Найти"
    var selectedAuthor: String
    var selectedBook: String = ""
    
    var body: some View {
        Button {
            withAnimation {
                isChatBookViewPresent =  true
            }
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(DarkButtonStyle())
        .simultaneousGesture(TapGesture().onEnded {
            sendSelectedCategory()
        })
        .navigationDestination(isPresented: $isChatBookViewPresent) {
            ChatBookView(chatBookViewModel: chatBookViewModel)
        }
        .disabled(selectedAuthor == "")
    }
    
    private func sendSelectedCategory() {
        var text = ""
        switch sendType {
        case .sameBook:
            text = "Хочу прочитать \(selectedAuthor), дай рецензию как минимум на 4 книги, с которых стоит начать читать данного автора,  так же обоснуй почему ты выбрал эти книги и еще расскажи один интерестный факт об \(selectedAuthor)"
        case .selectAutor:
            text = "Читал \(selectedAuthor) - \(selectedBook) на основании этого  предложи 5 стилистический похожие книги, так же напиши почему ты выбрал эти книги"
        }
        
        Task {
            await chatBookViewModel.send(text: text)
        }
    }
}




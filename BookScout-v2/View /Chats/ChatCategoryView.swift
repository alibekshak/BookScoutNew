//
//  ChatCategoryView.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

struct ChatCategoryView: View {
    
    @StateObject var chatCategoryViewModel: ChatCategoryViewModel
    
    @FocusState var isTextFieldFocused: Bool
    
    @State private var showingSheet = false
    @State private var addToFavoritesTapped = false
    
    var title: String
    
    var body: some View {
        ZStack {
            CustomColors.backgroundColor
                .ignoresSafeArea()
            VStack(spacing: .zero) {
                navigationBar
                Divider()
                chatList
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            chatCategoryViewModel.loadFavorites()
        }
    }
    
    var navigationBar: some View {
        HStack {
            Chevron(isDisabled: chatCategoryViewModel.isInteractingWithChatGPT)
            Spacer()
            Text(title)
                .foregroundColor(.black)
                .font(Font.montserratSemiBold_26)
                .padding(.trailing)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
    }
    
    var chatList: some View {
        ScrollViewReader { proxy in
            VStack(spacing: .zero) {
                ScrollView {
                    chatCategoryViewModel.isInteractingWithChatGPT ?
                    AnyView(loadingView) : AnyView(mainText)
                }
                bottomView(proxy: proxy)
            }
            .onChange(of: chatCategoryViewModel.messages.last?.responseText) { _ in scrollToBottom(proxy: proxy)
            }
        }
    }
    
    var loadingView: some View {
        LoaderView()
            .padding(.top, 300)
    }
    
    var mainText: some View {
        VStack(spacing: .zero) {
            ForEach(chatCategoryViewModel.messages) { message in
                MessageRowView(message: message) { message in
                    Task { @MainActor in
                        await chatCategoryViewModel.retry(message: message)
                    }
                }
            }
        }
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
    
    func bottomView(proxy: ScrollViewProxy) -> some View {
        VStack {
            if !chatCategoryViewModel.isInteractingWithChatGPT {
                suggestButton(proxy: proxy)
                tabView
            }
        }
    }
    
    func suggestButton(proxy: ScrollViewProxy) -> some View {
        Button {
            Task {
                isTextFieldFocused = false
                scrollToBottom(proxy: proxy)
                await chatCategoryViewModel.sendTapped()
            }
        } label: {
            Text("Предложить еще книгу")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(DarkButtonStyle())
        .padding(.horizontal, 20)
    }
    
    var tabView: some View {
        VStack(spacing: .zero) {
                Divider()
                HStack(alignment: .center, spacing: 120) {
                    buttonSheet
                    if let generatedText = chatCategoryViewModel.messages.last?.responseText {
                        bookmark(generatedText: generatedText)
                    }
                }
                .padding(.top, 8)
        }
    }
    
    func bookmark(generatedText: String) -> some View {
        Button {
            withAnimation {
                addToFavoritesTapped.toggle()
                chatCategoryViewModel.addToFavorites(text: generatedText)
            }
        } label: {
            Image(systemName: "bookmark.fill")
                .foregroundColor(.black)
                .font(.title)
        }
        .alert(isPresented: $addToFavoritesTapped) {
            Alert(
                title: Text("Избранное"),
                message: Text("Текст добавлен в избранное"),
                dismissButton: .default(Text("Ок"))
            )
        }
    }
    
    var buttonSheet: some View {
        Button {
            withAnimation {
                self.showingSheet = true
            }
        } label: {
            Image(systemName: "exclamationmark.octagon")
                .foregroundColor(Color.black)
                .font(.title)
        }
        .actionSheet(isPresented: $showingSheet) {
            ActionSheet(
                title:Text("Пожалуйста, обратите внимание"),
                message: Text("Искусственного интеллекта может допускать ошибки в распознавании и упоминании названий книг или имен авторов"),
                buttons: [.default(Text("Ок"))]
            )
        }
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let id = chatCategoryViewModel.messages.last?.id else { return
        }
        withAnimation {
            proxy.scrollTo(id, anchor: .bottom)
        }
    }
}

struct ChatCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChatCategoryView(chatCategoryViewModel: ChatCategoryViewModel(api: APIManager.shared.api, category: "CATEGORY_VALUE"), title: "Роман")
        }
    }
}

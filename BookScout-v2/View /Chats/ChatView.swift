//
//  ChatView.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject var chatViewModel: ChatViewModel
    @FocusState var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            CustomColors.backgroundColor
                .ignoresSafeArea()
            VStack(spacing: .zero) {
                navigationBar
                Divider()
                chatListView
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var navigationBar: some View {
        HStack {
            Spacer()
            Text("Чат AI")
                .foregroundColor(.black)
                .font(Font.montserratSemiBold_26)
                .padding(.leading)
            Spacer()
            refreshButton
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
    }
    
    var chatListView: some View {
        ScrollViewReader { proxy in
            VStack(spacing: .zero) {
                chatViewModel.isInteractingWithChatGPT ?
                AnyView(loadingView) : AnyView(messages)
                bottomView(proxy: proxy)
            }
            .onChange(of: chatViewModel.messages.last?.responseText) { _ in
                scrollToBottom(proxy: proxy)
            }
        }
    }
    
    var loadingView: some View {
        VStack(alignment: .center) {
            LoaderView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    var messages: some View {
        ScrollView {
            VStack(spacing: .zero) {
                ForEach(chatViewModel.messages) { message in
                    MessageRowView(message: message) { message in
                        Task { @MainActor in
                            await chatViewModel.retry(message: message)
                        }
                    }
                }
            }
        }
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
    
    func bottomView(proxy: ScrollViewProxy) -> some View {
        HStack(alignment: .center) {
            textField
            buttonSend(proxy: proxy)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 4)
        .padding(.top, 12)
    }
    
    func buttonSend(proxy: ScrollViewProxy) -> some View {
        Button {
            Task { @MainActor in
                isTextFieldFocused = false
                scrollToBottom(proxy: proxy)
                await chatViewModel.sendTapped()
            }
        } label: {
            Image(systemName: "paperplane.circle.fill")
                .rotationEffect(.degrees(45))
                .font(Font.montserratRegular_30)
        }
        .buttonStyle(.borderless)
        .foregroundColor(.accentColor)
        .disabled(chatViewModel.inputMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || chatViewModel.isInteractingWithChatGPT)
    }
    
    var textField: some View {
        TextField("Отправить сообщение", text: $chatViewModel.inputMessage, axis: .vertical)
            .textFieldStyle(.plain)
            .padding(6)
            .focused($isTextFieldFocused)
            .disabled(chatViewModel.isInteractingWithChatGPT)
            .font(Font.montserratRegular_18)
            .background(.white)
            .foregroundColor(.black)
            .cornerRadius(8)
            .padding(.bottom, 6)
            .onChange(of: isTextFieldFocused) { newValue in
                if newValue == true {
                    chatViewModel.isTabViewMainМisible = true
                } else {
                    chatViewModel.isTabViewMainМisible = false
                }
            }
    }
    
    var refreshButton: some View {
        Button(action: {
            chatViewModel.refreshChat()
        }) {
            Image(systemName: "arrow.clockwise")  .foregroundColor(.black)
                .font(Font.montserratSemiBold_24)
                .opacity(chatViewModel.isInteractingWithChatGPT ? 0 : 1)
        }
    }
    
    func scrollToBottom(proxy: ScrollViewProxy) {
        guard let id = chatViewModel.messages.last?.id else { return }
        proxy.scrollTo(id, anchor: .bottomTrailing)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(chatViewModel: ChatViewModel(api: APIManager.shared.api))
    }
}


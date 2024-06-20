//
//  CategoriesView.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

import SwiftUI

struct CategoriesView: View {
    
    @StateObject var viewModel: CategoriesViewModel
    
    var API: ChatGPTAPI
    
    @State private var showingSheet = false
    @State private var isActive: Bool = false
    
    var body: some View {
        ZStack {
            CustomColors.backgroundColor
                .ignoresSafeArea()
            VStack(spacing: .zero) {
                navigationBar
                categoriesScroll
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var categoriesScroll: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(viewModel.categoriess) { category in
                    CategoryView(
                        chatCategoryViewModel: ChatCategoryViewModel(
                            api: API, category: category.title),
                        isActive: $isActive,
                        title: category.title,
                        text: category.text,
                        text_send: category.textSend
                    )
                }
            }
            .padding(.vertical, 10)
        }
    }
    
    var navigationBar: some View {
        HStack {
            Chevron()
            Spacer()
            Text(viewModel.categoryName == .nonFiction ? "Выбери категорию:" : "Выбери жанр:")
                .foregroundColor(Color.black)
                .font(Font.montserratSemiBold_24)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

#Preview {
    CategoriesView(viewModel: CategoriesViewModel(categoryName: .fiction), API: APIManager.shared.api)
}

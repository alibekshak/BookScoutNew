//
//  FavoritesListView.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

struct FavoritesListView: View {
    
    @StateObject var viewModel: FavoritesViewModel
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
            CustomColors.backgroundColor
            VStack {
                navigationBar
                List {
                    ForEach(viewModel.favoriteItems) { item in
                        Text(item.title)
                            .foregroundColor(.black)
                            .listRowBackground(colorScheme == .dark ? CustomColors.backgroundColor : .white)
                    }
                    .onDelete(perform: viewModel.deleteFavoriteItem)
                    .onMove(perform: viewModel.moveFavoriteItem)
                }
                .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
            }
        }
        .onAppear {
            viewModel.refreshFavoriteItems()
        }
    }
    
    var navigationBar: some View {
        HStack {
            Button(action: {
                isEditing.toggle()
            }, label: {
                Image(systemName: isEditing ? "line.3.horizontal.decrease" : "line.horizontal.3")
                    .font(Font.montserratSemiBold_22)
            })
            Spacer()
            Text("Избранное")
                .font(Font.montserratSemiBold_20)
                .foregroundColor(.black)
                .padding(.leading)
            Spacer()
            XmarkButton()
        }
        .padding(.top)
        .padding(.horizontal, 20)
    }
}


//
//  NewIconView.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

enum ViewState {
    case standard
    case alternative
}

struct NewIconView: View {
    
    var image: String
    var title: String
    var backgroundColor: Color
    
    @State var viewState: ViewState
    
    var body: some View {
        Group {
            if viewState == .standard {
                VStack(spacing: 14) {
                    Image(systemName: image)
                        .font(Font.montserratSemiBold_36)
                    Text(title)
                        .font(Font.montserratSemiBold_16)
                        .multilineTextAlignment(.center)
                }
            } else {
                HStack(alignment: .center, spacing: 16) {
                    Image(systemName: image)
                        .font(Font.montserratSemiBold_36)
                        .padding(.leading)
                    Text(title)
                        .font(Font.montserratSemiBold_18)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.vertical, 26)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(backgroundColor)
        .foregroundColor(.white)
        .cornerRadius(20)
    }
}

#Preview {
    NewIconView(image: "book.pages", title: "Художественная литература", backgroundColor: Color(red: 173/255, green: 216/255, blue: 230/255), viewState: .alternative)
}

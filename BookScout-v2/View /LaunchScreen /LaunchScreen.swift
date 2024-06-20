//
//  LaunchScreen.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

struct LaunchScreen: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            CustomColors.backgroundColor
                .ignoresSafeArea()
            VStack(spacing: 16) {
                Text("BookScout")
                    .font(Font.manropeBold_36)
                Image(systemName: "book.closed")
                    .font(
                        Font.montserratSemiBold_90
                    )
                    .rotationEffect(.degrees(15), anchor: .center)
            }
            .foregroundColor(.black)
            .scaleEffect(isAnimating ? 1 : 0.5)
            .animation(.easeInOut(duration: 1.3), value: isAnimating)
            LoaderView()
                .padding(.top, 340)
        }
        .onAppear {
            self.isAnimating = true
        }
    }
}

#Preview {
    LaunchScreen()
}

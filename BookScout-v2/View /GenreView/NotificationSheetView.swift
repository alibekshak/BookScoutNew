//
//  NotificationSheetView.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

import SwiftUI

struct NotificationSheetView: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                CustomColors.customBlack
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isShowing = false
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
                mainInfo
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .cornerRadius(14, corners: [.topLeft, .topRight])
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
    
    var mainInfo: some View {
        VStack(spacing: 12) {
            Image(systemName: "books.vertical.circle")
                .font(
                    Font.montserratSemiBold_42
                )
            Text("Изменения добавлены")
                .font(
                    Font.montserratSemiBold_22
                )
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 230)
        .transition(.opacity.combined(with: .move(edge: .bottom)))
    }
}

#Preview {
    NotificationSheetView(isShowing: .constant(true))
}

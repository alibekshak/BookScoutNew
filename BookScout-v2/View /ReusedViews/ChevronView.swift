//
//  ChevronView.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

struct Chevron: View {
    
    var isDisabled: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            withAnimation {
                dismiss()
            }
        }) {
            Image(systemName: "chevron.left")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.black)
        }
        .disabled(isDisabled)
    }
}

#Preview {
    Chevron()
}

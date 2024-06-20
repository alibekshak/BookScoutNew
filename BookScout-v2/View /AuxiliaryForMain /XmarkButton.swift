//
//  XmarkButton.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

struct XmarkButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            withAnimation {
                dismiss()
            }
        } label: {
            Image(systemName: "xmark")
        }
        .buttonStyle(RoundedButtonStyle())
    }
}

#Preview {
    XmarkButton()
}

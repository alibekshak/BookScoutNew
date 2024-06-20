//
//  RoundedButtonStyle.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    private let feedbackGenerator: UIImpactFeedbackGenerator
    private let backgroundColor: Color

    public init(
        feedbackGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft),
        backgroundColor: Color = Color(.systemGray).opacity(0.15)
    ) {
        self.feedbackGenerator = feedbackGenerator
        self.backgroundColor = backgroundColor
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold))
            .padding(.vertical, 15)
            .padding(.horizontal, 16)
            .foregroundStyle(Color(.label))
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(backgroundColor)
            )
            .opacity(configuration.isPressed ? 0.6 : 1)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.interactiveSpring(blendDuration: 0.4), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { newValue in
                if newValue {
                    feedbackGenerator.impactOccurred()
                }
            }
    }
}

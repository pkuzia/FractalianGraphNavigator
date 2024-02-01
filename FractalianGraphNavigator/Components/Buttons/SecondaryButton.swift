//
//  SecondaryButton.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

struct SecondaryButton: View {
    var title: String
    var action: () -> Void

    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .style(.headline3)
                .foregroundColor(.primaryGreen)
                .padding(.horizontal, Spacing.base)
                .frame(maxWidth: .infinity)
                .frame(height: 54.0)
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.base)
                        .stroke(Color.green, lineWidth: 1.0)
                )
                .background(.clear)
        }
    }
}

#Preview {
    SecondaryButton(title: "Title example", action: {})
}

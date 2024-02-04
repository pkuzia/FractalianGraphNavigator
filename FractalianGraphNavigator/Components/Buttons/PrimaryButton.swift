//
//  PrimaryButton.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

struct PrimaryButton: View {
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
                .foregroundColor(.primaryWhite)
                .padding(.horizontal, Spacing.base)
                .frame(maxWidth: .infinity)
                .frame(height: 54.0)
                .background(.primaryGreen)
                .cornerRadius(CornerRadius.base)
        }
    }
}

#Preview {
    PrimaryButton(title: "Title example", action: {})
}

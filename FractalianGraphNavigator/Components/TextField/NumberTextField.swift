//
//  NumberTextField.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 02/02/2024.
//

import SwiftUI
import Combine

struct NumberTextField: View {
    @Binding var text: String

    var title: String
    var placeholder: String

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            Text(title)
                .style(.headline3)
                .foregroundColor(.textBlack)
                .padding(.horizontal, Spacing.micro)

            TextField(placeholder, text: $text)
                .frame(height: 54.0)
                .padding(.horizontal, Spacing.base)
                .cornerRadius(CornerRadius.base)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.backgroundShadow, lineWidth: 1)
                )
                .keyboardType(.numberPad)
                .onReceive(Just(text)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        text = filtered
                    }
                }
        }
        .padding(.horizontal, Spacing.base)
    }
}

#Preview {
    NumberTextField(
        text: .constant(""),
        title: "Title",
        placeholder: "Enter numbers"
    )
}

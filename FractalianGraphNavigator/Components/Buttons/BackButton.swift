//
//  BackButton.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

struct BackButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(uiImage: .backChevronIcon)
                .frame(width: 30.0, height: 30.0)
                .background(
                    RoundedRectangle(cornerRadius: CornerRadius.regular)
                        .foregroundColor(.primaryWhite)
                )
        }
    }
}

#Preview {
    BackButton(action: {})
}

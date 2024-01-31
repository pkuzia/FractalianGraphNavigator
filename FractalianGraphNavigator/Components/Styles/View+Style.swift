//
//  View+Style.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

extension View {
    func style(_ style: TextStyle) -> some View {
        self
            .font(SwiftUI.Font(style.font))
            .lineSpacing(style.lineSpacing)
    }
}

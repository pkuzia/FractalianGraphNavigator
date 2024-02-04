//
//  NavBarTitleModifier.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 02/02/2024.
//

import SwiftUI

struct NavBarTitleModifier: ViewModifier {
    var title: String

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .style(.headline3)
                        .foregroundColor(.textBlack)
                }
            }
    }
}

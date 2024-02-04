//
//  BackButtonModifier.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

struct BackButtonModifier: ViewModifier {
    var dismissAction: () -> Void

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    BackButton {
                        dismissAction()
                    }
                }
            }
    }
}

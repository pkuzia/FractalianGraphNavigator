//
//  LoadingView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

struct LoadingView: View {
    @Binding private var isLoading: Bool

    init(_ isLoading: Binding<Bool>) {
        self._isLoading = isLoading
    }

    var body: some View {
        ZStack {
            if isLoading {
                Color.white.opacity(0.5)
                ProgressView()
            }
        }
        .animation(.linear, value: isLoading)
    }
}

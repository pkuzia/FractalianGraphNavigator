//
//  BaseView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

public struct BaseView<Content: View>: View {

    private let content: () -> Content

    @Binding private var isLoading: Bool
    @Binding private var isError: Bool

    init(
        isLoading: Binding<Bool>,
        isError: Binding<Bool>,
        content: @escaping () -> Content
    ) {
        self._isLoading = isLoading
        self._isError = isError
        self.content = content
    }

    public var body: some View {
        ZStack {
            content()
            
            LoadingView($isLoading)
                .ignoresSafeArea()
        }
        .alert(isPresented: $isError) {
            Alert(
                title: Text(String.commonErrorTitle),
                message: Text(String.commonErrorMessage),
                dismissButton: .default(
                    Text(String.commonErrorOk)
                )
            )
        }
    }
}

extension View {
    func baseView(
        isLoading: Binding<Bool>,
        isError: Binding<Bool>
    ) -> some View {
        BaseView(
            isLoading: isLoading,
            isError: isError,
            content: { self }
        )
    }
}

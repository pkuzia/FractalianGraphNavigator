//
//  LoadGraphView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

struct LoadGraphView: View {
    @Environment(\.dismiss) var dismissAction

    var body: some View {
        ZStack {
            Background()
            VStack(spacing: Spacing.xLarge) {
                CenterLogo()

                BaseLabelsGroup(
                    title: .loadGraphTitle,
                    subtitle: .loadGraphSubtitle
                )

                PrimaryButton(
                    title: .startScreenButtonsLoad,
                    action: {
                        //                        path.append(StartViewDestinations.loadGraph)
                    }
                )
            }
        }
        .padding(.horizontal, Spacing.xLarge)
        .modifier(
            BackButtonModifier(dismissAction: {
                dismissAction()
            })
        )
    }
}

private struct CenterLogo: View {
    var body: some View {
        Circle()
            .frame(width: 215, height: 215)
            .foregroundColor(.backgroundGreenHue3)
            .overlay(
                Image(uiImage: .pageLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            )

    }
}

#Preview {
    LoadGraphView()
}

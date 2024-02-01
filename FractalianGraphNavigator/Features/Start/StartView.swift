//
//  StartView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

struct StartView: View {

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Background()
                    .ignoresSafeArea()
                ContextBackground()
                ContentView(path: $path)
            }
            .modifier(
                StartViewDestinationHandler(path: $path)
            )
        }
    }
}

private struct ContentView: View {

    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: Spacing.base) {
            Spacer()

            CenterLogo()

            Spacer()

            VStack(spacing: Spacing.xLarge) {
                BaseLabelsGroup(
                    title: .startScreenTitle,
                    subtitle: .startScreenSubtitle
                )

                VStack(spacing: Spacing.base) {
                    PrimaryButton(
                        title: .startScreenButtonsLoad,
                        action: {
                            path.append(StartViewDestinations.loadGraph)
                        }
                    )

                    PrimaryButton(
                        title: .startScreenButtonsGenerate,
                        action: {
                            path.append(StartViewDestinations.generateGraph)
                        }
                    )
                }
            }

            Spacer()
        }
        .padding(.horizontal, Spacing.xLarge)
    }
}

private struct CenterLogo: View {
    var body: some View {
        Circle()
            .frame(width: 200, height: 200)
            .foregroundColor(.primaryWhite)
            .overlay(
                Image(uiImage: .graphLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            )
            .shadow(
                color: .backgroundShadow,
                radius: 8.0,
                x: 4.0,
                y: 4.0
            )
    }
}

private struct ContextBackground: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Circle()
                        .frame(
                            width: geometry.size.width * 0.9,
                            height: geometry.size.width * 0.9
                        )
                        .foregroundColor(.primaryGreen)
                        .padding(.horizontal, -geometry.size.width * 0.25)
                        .padding(.vertical, -geometry.size.width * 0.2)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
#Preview {
    StartView()
}

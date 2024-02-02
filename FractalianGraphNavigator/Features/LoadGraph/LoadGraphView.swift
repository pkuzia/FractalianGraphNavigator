//
//  LoadGraphView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI
import UniformTypeIdentifiers

@MainActor
struct LoadGraphView: View {

    @EnvironmentObject private var graphManager: GraphManager
    @Environment(\.dismiss) private var dismissAction

    @State private var isFilePickerPresented = false
    @State private var isLoading: Bool = false
    @State private var isError: Bool = false
    
    @Binding var path: NavigationPath

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
                        isFilePickerPresented.toggle()
                    }
                )
            }
        }
        .padding(.horizontal, Spacing.xLarge)
        .fileImporter(
            isPresented: $isFilePickerPresented,
            allowedContentTypes: [UTType.xml],
            onCompletion: handleFileSelection
        )
        .modifier(
            LoadGraphDestinationsHandler()
        )
        .modifier(
            BackButtonModifier(dismissAction: {
                dismissAction()
            })
        )
        .modifier(
            NavBarTitleModifier(
                title: String.loadGraphNavBarTitle
            )
        )
        .baseView(
            isLoading: $isLoading,
            isError: $isError
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

extension LoadGraphView {
    private func handleFileSelection(result: Result<URL, Error>) {
        switch result {
        case .success(let selectedURL):
            Task(priority: .userInitiated) {
                isLoading = true
                do {
                    graphManager.graph = try await GraphFileReader().readGraphFromFile(
                        atPath: selectedURL.path
                    )
                    isLoading = false
                    path.append(LoadGraphDestinations.graphViewer)
                } catch {
                    isError = true
                    isLoading = false
                }
            }
        case .failure:
            isError = true
        }
    }
}

#Preview {
    LoadGraphView(
        path: .constant(NavigationPath())
    )
}

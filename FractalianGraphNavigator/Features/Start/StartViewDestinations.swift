//
//  StartViewDestinations.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

enum StartViewDestinations {
    case loadGraph
    case generateGraph
}

struct StartViewDestinationHandler: ViewModifier {
    @Binding var path: NavigationPath

    func body(content: Content) -> some View {
        content
            .navigationDestination(for: StartViewDestinations.self) { destination in
                switch destination {
                case .loadGraph:
                    LoadGraphView(path: $path)
                case .generateGraph:
                    Text("generateGraph")
                }
            }
    }
}

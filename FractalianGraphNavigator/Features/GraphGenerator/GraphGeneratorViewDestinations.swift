//
//  GraphGeneratorViewDestinations.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 03/02/2024.
//

import SwiftUI

enum GraphGeneratorViewDestinations {
    case graphViewer
}

struct GraphGeneratorViewDestinationsHandler: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: GraphGeneratorViewDestinations.self) { destination in
                switch destination {
                case .graphViewer:
                    GraphViewer()
                }
            }
    }
}

//
//  LoadGraphDestinations.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 01/02/2024.
//

import SwiftUI

enum LoadGraphDestinations {
    case graphViewer
}

struct LoadGraphDestinationsHandler: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: LoadGraphDestinations.self) { destination in
                switch destination {
                case .graphViewer:
                    GraphViewer()
                }
            }
    }
}

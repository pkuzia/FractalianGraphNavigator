//
//  GraphNode.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 27/01/2024.
//

import Foundation

final class GraphNode {
    var value: String
    var neighbors: [GraphNode] = []

    init(value: String) {
        self.value = value
    }
}

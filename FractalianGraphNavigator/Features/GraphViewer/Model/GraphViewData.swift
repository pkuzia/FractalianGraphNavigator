//
//  GraphViewData.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 01/02/2024.
//

import Foundation

final class GraphViewData: ObservableObject {
    @Published var title: String
    @Published var nodes: [GraphNodeViewData]

    init(title: String, nodes: [GraphNodeViewData]) {
        self.title = title
        self.nodes = nodes
    }
}

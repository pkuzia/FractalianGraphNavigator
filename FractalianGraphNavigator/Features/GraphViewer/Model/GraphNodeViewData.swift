//
//  GraphNodeViewData.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 01/02/2024.
//

import Foundation

class GraphNodeViewData: ObservableObject, Identifiable {

    @Published var id = UUID()
    @Published var title: String
    @Published var nodes: [GraphInnerNodeViewData]

    init(title: String, nodes: [GraphInnerNodeViewData]) {
        self.title = title
        self.nodes = nodes
    }
}

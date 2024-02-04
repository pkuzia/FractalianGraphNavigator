//
//  GraphViewData.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 01/02/2024.
//

import Foundation

final class GraphViewData {
    var id: UUID
    var title: String
    var nodes: [GraphNodeViewData]

    init(
        id: UUID,
        title: String,
        nodes: [GraphNodeViewData]
    ) {
        self.title = title
        self.nodes = nodes
        self.id = id
    }
}

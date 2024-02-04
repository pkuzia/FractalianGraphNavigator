//
//  GraphNode+ViewData.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 04/02/2024.
//

import Foundation

extension GraphNode {
    var plainViewData: GraphInnerNodeViewData {
        .init(value: value)
    }

    func buildViewData(maxElements: Int) -> GraphNodeViewData {
        return .init(
            id: id,
            title: value,
            nodes: neighbors
                .prefix(maxElements)
                .map { $0.plainViewData }
        )
    }
}

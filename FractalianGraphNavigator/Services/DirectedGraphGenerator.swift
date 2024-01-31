//
//  DirectedGraphGenerator.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import Foundation

class DirectedAcyclicGraphGenerator {

    func generateDAG(width: Int, height: Int, probability: Int = 10) -> Graph {
        let graph = Graph()

        var nodes = Int.zero

        for _ in .zero..<height {
            let newNodes = width

            for outerIndex in .zero..<nodes {
                for innerIndex in .zero..<newNodes {
                    if randomPercent() < probability,
                       let sourceNode = graph.fetchOrCreateNode(id: outerIndex),
                       let targetNode = graph.fetchOrCreateNode(id: innerIndex) {
                        try? graph.addEdge(from: sourceNode, to: targetNode)
                    }
                }
            }
            nodes += newNodes
        }
        return graph
    }

    private func randomPercent() -> Int {
        Int.random(in: 0...100)
    }
}

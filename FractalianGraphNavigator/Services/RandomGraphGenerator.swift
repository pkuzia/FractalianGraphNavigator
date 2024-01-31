//
//  RandomGraphGenerator.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 28/01/2024.
//

import Foundation

class RandomGraphGenerator {

    func generateGraph(nodes: Int, maxEdgesPerNode: Int) -> Graph {
        let graph = Graph()

        for node in .zero..<nodes {
            var edgesAdded = Int.zero
            let maxEdges = Int.random(in: 0...maxEdgesPerNode)

            guard let sourceNode = graph.fetchOrCreateNode(id: node) else {
                continue
            }

            while edgesAdded < maxEdges {
                let randomVertex = Int.random(in: 0..<nodes)

                if let targetNode = graph.fetchOrCreateNode(id: randomVertex) {
                    if targetNode.neighbors.count < maxEdges {
                        try? graph.addEdge(from: sourceNode, to: targetNode)
                        edgesAdded += 1
                    }
                }
            }
        }

        return graph
    }
}

//
//  AcyclicGraphGenerator.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import Foundation

/**
 Asynchronously generates a Directed Acyclic Graph (DAG) with the specified width and height, introducing edges based on a given probability.
 The function creates nodes in rows, connecting each node from the current row to nodes in the next row with a probability defined by the parameter.

 - Parameters:
 - width: The number of nodes in each row.
 - height: The number of rows in the graph.
 - probability: The probability (percentage) of creating an edge between nodes in consecutive rows. Defaults to 10.

 - Returns: A Directed Acyclic Graph (DAG) with the specified width, height, and edge probability.
 */

class AcyclicGraphGenerator {

    func generateDAG(width: Int, height: Int, probability: Int = 10) async -> Graph {
        return await withCheckedContinuation { continuation in
            let graph = Graph()

            var nodes = Int.zero

            for _ in .zero..<height {
                let newNodes = width

                for outerIndex in .zero..<nodes {
                    for innerIndex in .zero..<newNodes {
                        if randomPercent() < probability,
                           let sourceNode = graph.fetchOrCreateNode(id: outerIndex),
                           let targetNode = graph.fetchOrCreateNode(id: innerIndex + nodes) {
                            try? graph.addEdge(from: sourceNode, to: targetNode)
                        }
                    }
                }
                nodes += newNodes
            }
            continuation.resume(returning: graph)
        }
    }

    private func randomPercent() -> Int {
        Int.random(in: 0...100)
    }
}

//
//  RandomGraphGenerator.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 28/01/2024.
//

import Foundation

/**
 Asynchronously generates a random graph with the specified number of nodes and a maximum number of edges per node.
 The function iterates through each node, randomly selecting a number of edges up to the specified maximum.
 For each edge, it connects the current node to a randomly chosen target node, ensuring that the target node does not exceed its maximum allowed edges.

 - Parameters:
   - nodes: The total number of nodes in the graph.
   - maxEdgesPerNode: The maximum number of edges each node can have.

 - Returns: A graph with randomly generated edges based on the provided parameters.
 */

class RandomGraphGenerator {

    func generateGraph(nodes: Int, maxEdgesPerNode: Int) async throws -> Graph {
        return try await withCheckedThrowingContinuation { continuation in
            let graph = Graph()

            for node in .zero..<nodes {
                var edgesAdded = Int.zero
                let maxEdges = Int.random(in: 0...maxEdgesPerNode)

                guard let sourceNode = graph.fetchOrCreateNode(id: node) else {
                    continue
                }

                while edgesAdded < maxEdges {
                    do {
                        try Task.checkCancellation()
                    } catch {
                        continuation.resume(throwing: CancellationError())
                        return
                    }

                    let randomVertex = Int.random(in: 0..<nodes)
                    if let targetNode = graph.fetchOrCreateNode(id: randomVertex) {
                        if targetNode.neighbors.count < maxEdges {
                            try? graph.addEdge(from: sourceNode, to: targetNode)
                            edgesAdded += 1
                        }
                    }
                }
            }

            continuation.resume(returning: graph)
        }
    }
}

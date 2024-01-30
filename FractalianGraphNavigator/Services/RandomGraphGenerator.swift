//
//  RandomGraphGenerator.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 28/01/2024.
//

import Foundation

class RandomGraphGenerator {
    func generateGraph(nodeCount: Int, maxEdges: Int, allowCycles: Bool = true) -> Graph {
        var graph = Graph()
        var nodeKeys: Set<String> = Set()

        for index in .zero..<nodeCount {
            let nodeId = "n\(index)"
            try? graph.addNode(id: nodeId)
            nodeKeys.insert(nodeId)
        }

        for index in .zero..<nodeCount {
            var remainingConnections = Int.random(in: 0..<maxEdges)

            while remainingConnections > 0 {
                let sourceNodeId = "n\(index)"
                if let targetNodeId = randomNodeExcept(forbiddenNode: sourceNodeId, in: nodeKeys) {
                    if allowCycles || !graph.hasPath(from: sourceNodeId, to: targetNodeId) {
                        try? graph.addEdge(fromId: sourceNodeId, toId: targetNodeId)
                        remainingConnections -= 1
                    }
                }
            }
        }

        return graph
    }

    private func randomNodeExcept(forbiddenNode: String, in nodeKeys: Set<String>) -> String? {
        let availableNodes = nodeKeys.subtracting([forbiddenNode])
        guard !availableNodes.isEmpty else { return nil }
        return availableNodes.randomElement()
    }
}

class DirectedGraphGenerator {
    var graph: Graph = Graph()

//    func generateDAG() -> Graph {
//        let MIN_PER_RANK = 200 // Nodes/Rank: How 'fat' the DAG should be.
//        let MAX_PER_RANK = 200
//        let MIN_RANKS = 200    // Ranks: How 'tall' the DAG should be.
//        let MAX_RANKS = 200
//        let PERCENT = 10
//
//        var nodes = 0
//        let ranks = Int.random(in: MIN_RANKS...MAX_RANKS)
//
////        print("digraph {")
//        for _ in 0..<ranks {
//            let newNodes = Int.random(in: MIN_PER_RANK...MAX_PER_RANK)
//
//            for outerIndex in 0..<nodes {
//                for innerIndex in 0..<newNodes {
//                    if Int.random(in: 0...100) < PERCENT {
//                        var sourceNode: GraphNode?
//                        var targetNode: GraphNode?
//
//                        if let node = graph.nodes["n\(outerIndex)"] {
//                            sourceNode = node
//                        } else {
//                            let nodeId = "n\(outerIndex)"
//                            try? graph.addNode(id: nodeId)
//                            sourceNode = graph.nodes["n\(outerIndex)"]
//                        }
//
//                        if let node = graph.nodes["n\(innerIndex + nodes)"] {
//                            targetNode = node
//                        } else {
//                            let nodeId = "n\(innerIndex + nodes)"
//                            try? graph.addNode(id: nodeId)
//                            targetNode = graph.nodes["n\(innerIndex + nodes)"]
//                        }
//
//                        // Create edge
//                        if let sourceNode = sourceNode, let targetNode = targetNode {
//                            try? graph.addEdge(from: sourceNode, to: targetNode)
////                            print("  \(outerIndex) -> \(innerIndex + nodes);") // An Edge.
//                        }
//                    }
//                }
//            }
//            nodes += newNodes
//        }

//        return graph
//        print("}")
//    }
}

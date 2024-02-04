//
//  RandomGraphGeneratorTests.swift
//  FractalianGraphNavigatorTests
//
//  Created by Przemysław Kuzia on 28/01/2024.
//

import XCTest

@testable import FractalianGraphNavigator

class GraphGeneratorTests: XCTestCase {

    func testGenerateRandomGraph() async {
        let generator = RandomGraphGenerator()

        let graph = await generator.generateGraph(nodes: 5, maxEdgesPerNode: 3)

        XCTAssertEqual(graph.nodes.count, 5)
        XCTAssertTrue(graph.nodes.keys.allSatisfy { $0.hasPrefix("n") })

        let totalEdges = graph.nodes.values.reduce(0) { $0 + $1.neighbors.count }
        XCTAssertLessThanOrEqual(totalEdges, 3 * 5)
    }

    func testGenerateAcyclicGraph() async {
        let generator = AcyclicGraphGenerator()

        let graph = await generator.generateDAG(width: 3, height: 3, probability: 50)

        XCTAssertEqual(graph.nodes.count, 9)
        XCTAssertTrue(graph.nodes.keys.allSatisfy { $0.hasPrefix("n") })

        let totalEdges = graph.nodes.values.reduce(0) { $0 + $1.neighbors.count }

        for (_, startNode) in graph.nodes {
            var visitedNodes: Set<String> = []
            XCTAssertFalse(hasCycle(from: startNode, visitedNodes: &visitedNodes))
        }
    }

    private func hasCycle(from node: GraphNode, visitedNodes: inout Set<String>) -> Bool {
        if visitedNodes.contains(node.value) {
            return true
        }

        visitedNodes.insert(node.value)

        for neighbor in node.neighbors where hasCycle(from: neighbor, visitedNodes: &visitedNodes) {
            return true
        }

        visitedNodes.remove(node.value)
        return false
    }
}

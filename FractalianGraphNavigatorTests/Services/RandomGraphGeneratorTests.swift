//
//  RandomGraphGeneratorTests.swift
//  FractalianGraphNavigatorTests
//
//  Created by Przemysław Kuzia on 28/01/2024.
//

import XCTest

@testable import FractalianGraphNavigator

class RandomGraphGeneratorTests: XCTestCase {

//    func testGenerateGraph() {
//        let generator = RandomGraphGenerator()
//
//        let graph = generator.generateGraph(nodeCount: 5, maxEdges: 3)
//
//        XCTAssertEqual(graph.nodes.count, 5)
//        XCTAssertTrue(graph.nodes.keys.allSatisfy { $0.hasPrefix("n") })
//
//        let totalEdges = graph.nodes.values.reduce(0) { $0 + $1.neighbors.count }
//        XCTAssertLessThanOrEqual(totalEdges, 3 * 5)
//    }
//
//    func testGenerateGraphWithoutCycles() {
//        let generator = RandomGraphGenerator()
//
//        let graph = generator.generateGraph(nodeCount: 5, maxEdges: 3, allowCycles: false)
//
//        XCTAssertEqual(graph.nodes.count, 5)
//        XCTAssertTrue(graph.nodes.keys.allSatisfy { $0.hasPrefix("n") })
//
//        let totalEdges = graph.nodes.values.reduce(0) { $0 + $1.neighbors.count }
//        XCTAssertLessThanOrEqual(totalEdges, 3 * 5)
//
//        for (sourceId, sourceNode) in graph.nodes {
//            for targetNode in sourceNode.neighbors {
//                XCTAssertFalse(graph.hasPath(from: targetNode.value, to: sourceId))
//            }
//        }
//
//        for (_, startNode) in graph.nodes {
//            var visitedNodes: Set<String> = []
//            XCTAssertFalse(hasCycle(from: startNode, visitedNodes: &visitedNodes))
//        }
//    }
//
//    func testGenerateHugeGraph() {
//        let generator = RandomGraphGenerator()
//        let acyclicGenerator = DirectedGraphGenerator()
//
//        let options = XCTMeasureOptions()
//        options.iterationCount = 1
//
//        measure(options: options, block: {
//            let graph = acyclicGenerator.generateDAG()
//            print(graph)
//        })
//    }
//
//    private func hasCycle(from node: GraphNode, visitedNodes: inout Set<String>) -> Bool {
//        if visitedNodes.contains(node.value) {
//            return true
//        }
//
//        visitedNodes.insert(node.value)
//
//        for neighbor in node.neighbors {
//            if hasCycle(from: neighbor, visitedNodes: &visitedNodes) {
//                return true
//            }
//        }
//
//        visitedNodes.remove(node.value)
//        return false
//    }
}

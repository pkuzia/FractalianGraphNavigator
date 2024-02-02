//
//  GraphManagerTests.swift
//  FractalianGraphNavigatorTests
//
//  Created by Przemysław Kuzia on 02/02/2024.
//

import XCTest
import Foundation

@testable import FractalianGraphNavigator

final class GraphManagerTests: XCTestCase {

    func testSettingInitialValue() {

        let graph = Graph()

        for index in 0...100 {
            _ = try? graph.addNode(id: "n\(index)")
        }

        for index in 1...50 {
            try? graph.addEdge(fromId: "n0", toId: "n\(index)")
        }

        let graphManager = GraphManager()
        graphManager.graph = graph

        XCTAssertNotNil(graphManager.activeNode)
        XCTAssertTrue(graphManager.activeNode!.title == "n0")
        XCTAssertTrue(graphManager.activeNode!.nodes.count == 10)

        for index in 1..<10 {
            XCTAssertTrue(graphManager.activeNode!.nodes.first(where: { $0.title == "n\(index)"}) != nil)
        }
    }

    func testPagination() {

        let graph = Graph()

        for index in 0...100 {
            _ = try? graph.addNode(id: "n\(index)")
        }

        for index in 1...34 {
            try? graph.addEdge(fromId: "n0", toId: "n\(index)")
        }

        let graphManager = GraphManager()
        graphManager.graph = graph

        XCTAssertTrue(graphManager.activeNode!.nodes.count == 10)

        graphManager.requestNextPage()
        XCTAssertTrue(graphManager.activeNode!.nodes.count == 20)

        graphManager.requestNextPage()
        XCTAssertTrue(graphManager.activeNode!.nodes.count == 30)

        graphManager.requestNextPage()
        XCTAssertTrue(graphManager.activeNode!.nodes.count == 34)

        graphManager.requestNextPage()
        XCTAssertTrue(graphManager.activeNode!.nodes.count == 34)
    }

    func testInnerPagination() {

        let graph = Graph()

        for index in 0...100 {
            _ = try? graph.addNode(id: "n\(index)")
        }

        for index in 1...50 {
            try? graph.addEdge(fromId: "n0", toId: "n\(index)")
        }

        for index in 2...34 {
            try? graph.addEdge(fromId: "n1", toId: "n\(index)")
        }

        let graphManager = GraphManager()
        graphManager.graph = graph

        var node = graphManager.activeNode!.nodes.first(where: { $0.title == "n1" })!
        XCTAssertTrue(node.nodes.count == 10)

        graphManager.requestNextInnerPage(for: node.id)
        node = graphManager.activeNode!.nodes.first(where: { $0.title == "n1" })!
        XCTAssertTrue(node.nodes.count == 20)

        graphManager.requestNextInnerPage(for: node.id)
        node = graphManager.activeNode!.nodes.first(where: { $0.title == "n1" })!
        XCTAssertTrue(node.nodes.count == 30)

        graphManager.requestNextInnerPage(for: node.id)
        node = graphManager.activeNode!.nodes.first(where: { $0.title == "n1" })!
        XCTAssertTrue(node.nodes.count == 33)

        graphManager.requestNextInnerPage(for: node.id)
        node = graphManager.activeNode!.nodes.first(where: { $0.title == "n1" })!
        XCTAssertTrue(node.nodes.count == 33)
    }

    func testChangingFolder() {
        let graph = Graph()

        for index in 0...100 {
            _ = try? graph.addNode(id: "n\(index)")
        }

        for index in 1...50 {
            try? graph.addEdge(fromId: "n0", toId: "n\(index)")
        }

        for index in 2...34 {
            try? graph.addEdge(fromId: "n1", toId: "n\(index)")
        }

        let graphManager = GraphManager()
        graphManager.graph = graph

        let n1Node = graph.nodes.first(where: { $0.key == "n1" })!.value
        XCTAssertTrue(graphManager.activeNode!.title == "n0")

        graphManager.selectNewNode(id: n1Node.id)
        XCTAssertTrue(graphManager.activeNode!.title == "n1")

        graphManager.restorePreviousGraphNode()
        XCTAssertTrue(graphManager.activeNode!.title == "n0")
    }
}

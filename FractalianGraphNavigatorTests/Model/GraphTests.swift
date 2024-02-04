//
//  GraphTests.swift
//  FractalianGraphNavigatorTests
//
//  Created by Przemysław Kuzia on 28/01/2024.
//

import XCTest

@testable import FractalianGraphNavigator

class GraphTests: XCTestCase {

    func testAddNode() {
        let graph = Graph()

        XCTAssertNoThrow(try graph.addNode(id: "n0"))
        XCTAssertEqual(graph.nodes.count, 1)

        XCTAssertThrowsError(try graph.addNode(id: "n0")) { error in
            XCTAssertEqual(error as? GraphReaderError, GraphReaderError.structuralError)
        }
    }

    func testAddEdge() {
        let graph = Graph()

        XCTAssertNoThrow(try graph.addNode(id: "n0"))
        XCTAssertNoThrow(try graph.addNode(id: "n1"))

        XCTAssertNoThrow(try graph.addEdge(fromId: "n0", toId: "n1"))
        XCTAssertEqual(graph.nodes["n0"]?.neighbors.count, 1)
        XCTAssertEqual(graph.nodes["n1"]?.neighbors.count, 0)

        XCTAssertThrowsError(try graph.addEdge(fromId: "n0", toId: "n2")) { error in
            XCTAssertEqual(error as? GraphReaderError, GraphReaderError.structuralError)
        }
    }

    func testPaths() {
        let graph = Graph()

        XCTAssertNoThrow(try graph.addNode(id: "n0"))
        XCTAssertNoThrow(try graph.addNode(id: "n1"))
        XCTAssertNoThrow(try graph.addNode(id: "n2"))
        XCTAssertNoThrow(try graph.addEdge(fromId: "n0", toId: "n1"))
        XCTAssertNoThrow(try graph.addEdge(fromId: "n1", toId: "n2"))

        XCTAssertTrue(graph.hasPath(from: "n0", to: "n2"))
        XCTAssertFalse(graph.hasPath(from: "n2", to: "n0"))
        XCTAssertFalse(graph.hasPath(from: "n0", to: "n3"))

        XCTAssertFalse(graph.hasPath(from: "n2", to: "n0"))
        XCTAssertFalse(graph.hasPath(from: "n2", to: "n3"))
    }
}

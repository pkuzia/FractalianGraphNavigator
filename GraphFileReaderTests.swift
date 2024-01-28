//
//  GraphFileReaderTests.swift
//  FractalianGraphNavigatorTests
//
//  Created by Przemysław Kuzia on 28/01/2024.
//

import XCTest
import Foundation

@testable import FractalianGraphNavigator

final class GraphFileReaderTests: XCTestCase {

    func testReadGraphWithCycles() {
        let bundle = Bundle(for: type(of: self))

        guard let temporaryFilePath = bundle.path(forResource: "GraphWithCycles", ofType: "xml") else {
            XCTFail("Can't read file")
            return
        }

        do {
            let graphFileReader = GraphFileReader()
            let graph = try graphFileReader.readGraphFromFile(atPath: temporaryFilePath)

            // Test the structure of the graph
            XCTAssertEqual(graph.nodes.count, 11)
            XCTAssertEqual(countEdges(in: graph), 14)

            // Test edge relationships
            XCTAssert(hasEdge(from: "n0", to: "n2", in: graph))
            XCTAssert(hasEdge(from: "n2", to: "n0", in: graph))
            XCTAssert(hasEdge(from: "n1", to: "n2", in: graph))
            XCTAssert(hasEdge(from: "n2", to: "n3", in: graph))
            XCTAssert(hasEdge(from: "n3", to: "n5", in: graph))
            XCTAssert(hasEdge(from: "n3", to: "n4", in: graph))
            XCTAssert(hasEdge(from: "n4", to: "n6", in: graph))
            XCTAssert(hasEdge(from: "n6", to: "n5", in: graph))
            XCTAssert(hasEdge(from: "n5", to: "n7", in: graph))
            XCTAssert(hasEdge(from: "n6", to: "n8", in: graph))
            XCTAssert(hasEdge(from: "n8", to: "n7", in: graph))
            XCTAssert(hasEdge(from: "n8", to: "n9", in: graph))
            XCTAssert(hasEdge(from: "n8", to: "n10", in: graph))
        } catch {
            XCTFail("Error occured: \(error)")
        }
    }

    func testReadGraphWithoutCycles() {
        let bundle = Bundle(for: type(of: self))

        guard let temporaryFilePath = bundle.path(forResource: "GraphWithoutCycles", ofType: "xml") else {
            XCTFail("Can't read file")
            return
        }

        do {
            let graphFileReader = GraphFileReader()
            let graph = try graphFileReader.readGraphFromFile(atPath: temporaryFilePath)

            // Test the structure of the graph
            XCTAssertEqual(graph.nodes.count, 11)
            XCTAssertEqual(countEdges(in: graph), 10)

            // Test edge relationships
            XCTAssert(hasEdge(from: "n0", to: "n1", in: graph))
            XCTAssert(hasEdge(from: "n1", to: "n2", in: graph))
            XCTAssert(hasEdge(from: "n2", to: "n3", in: graph))
            XCTAssert(hasEdge(from: "n3", to: "n4", in: graph))
            XCTAssert(hasEdge(from: "n4", to: "n5", in: graph))
            XCTAssert(hasEdge(from: "n5", to: "n6", in: graph))
            XCTAssert(hasEdge(from: "n6", to: "n7", in: graph))
            XCTAssert(hasEdge(from: "n7", to: "n8", in: graph))
            XCTAssert(hasEdge(from: "n8", to: "n9", in: graph))
            XCTAssert(hasEdge(from: "n9", to: "n10", in: graph))
        } catch {
            XCTFail("Error occured: \(error)")
        }
    }

    func testReadGraphCorrupedStructure() {
        let bundle = Bundle(for: type(of: self))

        guard let temporaryFilePath = bundle.path(forResource: "GraphCorruptedStructure", ofType: "xml") else {
            XCTFail("Can't read file")
            return
        }

        do {
            let graphFileReader = GraphFileReader()
            _ = try graphFileReader.readGraphFromFile(atPath: temporaryFilePath)
            XCTFail("Expected an error but the operation succeeded")
        } catch let error as GraphReaderError {
            XCTAssertTrue(error == GraphReaderError.structuralError)
        } catch {
            XCTFail("Unexpected error type: \(type(of: error))")
        }
    }

    func testReadGraphCorrupedXML() {
        let bundle = Bundle(for: type(of: self))

        guard let temporaryFilePath = bundle.path(forResource: "GraphCorruptedXML", ofType: "xml") else {
            XCTFail("Can't read file")
            return
        }

        let graphFileReader = GraphFileReader()
        XCTAssertThrowsError(try graphFileReader.readGraphFromFile(atPath: temporaryFilePath))
    }

    private func countEdges(in graph: Graph) -> Int {
        return graph.nodes.values.reduce(0) { $0 + $1.neighbors.count }
    }

    private func hasEdge(from source: String, to target: String, in graph: Graph) -> Bool {
        guard let sourceNode = graph.nodes[source], let targetNode = graph.nodes[target] else {
            return false
        }

        return sourceNode.neighbors.contains(where: { $0.value == targetNode.value })
        || targetNode.neighbors.contains(where: { $0.value == sourceNode.value })
    }
}

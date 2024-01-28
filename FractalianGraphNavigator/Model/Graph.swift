//
//  Graph.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 27/01/2024.
//

import Foundation

enum GraphReaderError: Error {
    case pathError
    case structuralError
}

final class Graph {
    var nodes: [String: GraphNode] = [:]

    func addNode(id: String) throws {
        if nodes[id] != nil {
            throw GraphReaderError.structuralError
        }

        nodes[id] = GraphNode(value: id)
    }

    func addEdge(fromId sourceId: String, toId destinationId: String) throws {
        guard let sourceNode = nodes[sourceId], let destinationNode = nodes[destinationId] else {
            throw GraphReaderError.structuralError
        }

        sourceNode.neighbors.append(destinationNode)
        destinationNode.neighbors.append(sourceNode)
    }
}

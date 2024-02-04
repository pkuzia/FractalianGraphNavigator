//
//  Graph.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 27/01/2024.
//

import Foundation

private enum Constants {
    static let nodeKeyFormat: String = "n%d"
}

enum GraphReaderError: Error {
    case pathError
    case structuralError
}

final class Graph {
    var nodes: [String: GraphNode] = [:]

    @discardableResult
    func addNode(id: String) throws -> GraphNode {
        if nodes[id] != nil {
            throw GraphReaderError.structuralError
        }

        let newNode = GraphNode(value: id)
        nodes[id] = newNode

        return newNode
    }

    func addEdge(fromId sourceId: String, toId destinationId: String) throws {
        guard let sourceNode = nodes[sourceId], let destinationNode = nodes[destinationId] else {
            throw GraphReaderError.structuralError
        }

        sourceNode.neighbors.append(destinationNode)
    }

    func addEdge(from sourceNode: GraphNode, to destinationNode: GraphNode) throws {
        sourceNode.neighbors.append(destinationNode)
    }

    @discardableResult
    func fetchOrCreateNode(id: Int) -> GraphNode? {
        let key = String.localizedStringWithFormat(
            Constants.nodeKeyFormat, id
        )

        if let node = nodes[key] {
            return node
        } else {
            return try? addNode(id: key)
        }
    }

    func hasPath(from sourceId: String, to targetId: String) -> Bool {
        guard let sourceNode = nodes[sourceId], let targetNode = nodes[targetId] else {
            return false
        }

        var visitedNodes: Set<String> = []
        return dfs(sourceNode: sourceNode, targetNode: targetNode, visitedNodes: &visitedNodes)
    }

    private func dfs(sourceNode: GraphNode, targetNode: GraphNode, visitedNodes: inout Set<String>) -> Bool {
        if sourceNode === targetNode {
            return true
        }

        visitedNodes.insert(sourceNode.value)

        for neighbor in sourceNode.neighbors where !visitedNodes.contains(neighbor.value) {
            if dfs(sourceNode: neighbor, targetNode: targetNode, visitedNodes: &visitedNodes) {
                return true
            }
        }

        return false
    }
}

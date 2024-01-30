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
    }

    func addEdge(from sourceNode: GraphNode, to destinationNode: GraphNode) throws {
        sourceNode.neighbors.append(destinationNode)
    }

    func hasPath(from sourceId: String, to targetId: String) -> Bool {
        guard let sourceNode = nodes[sourceId], let targetNode = nodes[targetId] else {
            return false
        }

        var visitedNodes: Set<String> = []
        return dfs(sourceNode: sourceNode, targetNode: targetNode, visitedNodes: &visitedNodes)
    }

    func topologicalSort() -> [String] {
        var result: [String] = []
        var visited: Set<String> = []

        func visit(_ node: GraphNode) {
            visited.insert(node.value)
            for neighbor in node.neighbors {
                if !visited.contains(neighbor.value) {
                    visit(neighbor)
                }
            }
            result.append(node.value)
        }

        for node in nodes.values {
            if !visited.contains(node.value) {
                visit(node)
            }
        }

        return result.reversed()
    }

    private func dfs(sourceNode: GraphNode, targetNode: GraphNode, visitedNodes: inout Set<String>) -> Bool {
        if sourceNode === targetNode {
            return true
        }

        visitedNodes.insert(sourceNode.value)

        for neighbor in sourceNode.neighbors {
            if !visitedNodes.contains(neighbor.value) {
                if dfs(sourceNode: neighbor, targetNode: targetNode, visitedNodes: &visitedNodes) {
                    return true
                }
            }
        }

        return false
    }
}

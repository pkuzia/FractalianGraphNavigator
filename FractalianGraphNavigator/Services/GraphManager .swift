//
//  GraphManager .swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 01/02/2024.
//

import Foundation
import Combine

private enum Constants {
    static let firstPage: Int = 1
    static let elementsPerPage: Int = 10

    static let n0Index: String = "n0"
}

final class GraphManager: ObservableObject {

    @Published var activeNode: GraphViewData?

    private var graphHistory: [GraphNode] = []
    private var activeGraphNode: GraphNode?
    private var activeNodePage: Int = Constants.firstPage
    private var activeNodesPages: [UUID: Int] = [:]

    var graph: Graph? {
        didSet {
            resetPagination()
            setInitialValue()
        }
    }

    func requestNextPage() {
        guard let activeNode = activeNode,
              let graphNode = graph?.nodes[activeNode.title],
              let activeGraphNode = activeGraphNode else { return }

        if activeNode.nodes.count < graphNode.neighbors.count {
            activeNodePage += 1
            self.activeNode?.nodes = buildNodesViewData(
                nodes: activeGraphNode.neighbors
            )
            objectWillChange.send()
        }
    }

    func requestNextInnerPage(for id: UUID) {
        guard let activeNode = activeNode,
              let activeGraphNode = activeGraphNode,
              let page = activeNodesPages[id] else { return }

        if let node = activeNode.nodes.first(where: { $0.id == id }),
           let graphNode = graph?.nodes[node.title],
           node.nodes.count < graphNode.neighbors.count {
            activeNodesPages[id] = page + 1
            self.activeNode?.nodes = buildNodesViewData(
                nodes: activeGraphNode.neighbors
            )
            objectWillChange.send()
        }
    }

    func selectNewNode(id: UUID) {
        if let activeGraphNode = activeGraphNode {
            graphHistory.append(activeGraphNode)
        }

        if let node = graph?.nodes.first(where: { $0.value.id == id })?.value {
            setActiveNode(node)
        }
    }

    func restorePreviousGraphNode() {
        if let previousGrapNode = graphHistory.popLast() {
            setActiveNode(previousGrapNode)
        }
    }

    private func setInitialValue() {
        graphHistory.removeAll()

        var firstNode: GraphNode?

        if let n0Node = graph?.nodes[Constants.n0Index] {
            firstNode = n0Node
        } else {
            firstNode = graph?.nodes.first?.value
        }

        if let firstNode = firstNode {
            setActiveNode(firstNode)
        }
    }

    private func setActiveNode(_ node: GraphNode) {
        activeGraphNode = node

        activeNode = GraphViewData(
            id: node.id,
            title: node.value,
            nodes: buildNodesViewData(
                nodes: node.neighbors
            )
        )
    }

    private func buildNodesViewData(nodes: [GraphNode]) -> [GraphNodeViewData] {
        nodes
            .prefix(activeNodePage * Constants.elementsPerPage)
            .compactMap { node in
                if let pageNumber = activeNodesPages[node.id] {
                    return node.buildViewData(
                        maxElements: pageNumber * Constants.elementsPerPage
                    )
                }

                return nil
            }
    }

    private func resetPagination() {
        guard let graph = graph else { return }

        activeNodePage = Constants.firstPage
        for node in graph.nodes {
            activeNodesPages[node.value.id] = Constants.firstPage
        }
    }
}

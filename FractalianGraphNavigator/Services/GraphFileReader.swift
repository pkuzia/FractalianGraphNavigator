//
//  GraphFileReader.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 27/01/2024.
//

import Foundation

private enum GraphMLKeys {
    static let id = "id"
    static let node = "node"
    static let edge = "edge"
    static let source = "source"
    static let target = "target"
}

final class GraphFileReader {

    func readGraphFromFile(atPath path: String) async throws -> Graph {
        try await GraphMLParser(path: path).parse()
    }
}

private class GraphMLParser: NSObject {
    private var graph: Graph = Graph()
    private var error: Error?

    private var currentEdgeSource: String?
    private var currentEdgeTarget: String?

    private let path: String

    init(path: String) {
        self.path = path
        super.init()
    }

    func parse() async throws -> Graph {
        return try await withCheckedThrowingContinuation { continuation in
            if let inputStream = InputStream(fileAtPath: path) {
                inputStream.open()
                parse(inputStream: inputStream)
                inputStream.close()

                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    Task {
                        try await Task.sleep(nanoseconds: 2 * 1_000_000_000) // Opóźnienie o 2 sekundy
                        continuation.resume(returning: graph)
                    }
                }
            } else {
                continuation.resume(throwing: GraphReaderError.pathError)
            }
        }
    }

    private func parse(inputStream: InputStream) {
        let xmlParser = XMLParser(stream: inputStream)
        xmlParser.delegate = self
        xmlParser.parse()
    }

    private func addNode(id: String) {
        do {
            try graph.addNode(id: id)
        } catch let graphError {
            error = graphError
        }
    }

    private func addEdge(fromId sourceId: String, toId destinationId: String) {
        do {
            try graph.addEdge(fromId: sourceId, toId: destinationId)
        } catch let graphError {
            error = graphError
        }
    }

    private func cleanResources() {
        currentEdgeSource = nil
        currentEdgeTarget = nil
    }
}

extension GraphMLParser: XMLParserDelegate {
    func parserDidStartDocument(_ parser: XMLParser) {
        cleanResources()
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        cleanResources()
    }

    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String] = [:]
    ) {
        switch elementName {
        case GraphMLKeys.node:
            if let id = attributeDict[GraphMLKeys.id] {
                addNode(id: id)
            }
        case GraphMLKeys.edge:
            currentEdgeSource = attributeDict[GraphMLKeys.source]
            currentEdgeTarget = attributeDict[GraphMLKeys.target]
        default:
            break
        }
    }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        switch elementName {
        case GraphMLKeys.edge:
            if let source = currentEdgeSource, let target = currentEdgeTarget {
                addEdge(fromId: source, toId: target)
            }
            currentEdgeSource = nil
            currentEdgeTarget = nil
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        error = parseError
    }
}

//
//  AcyclicGraphGeneratorTests.swift
//  FractalianGraphNavigatorTests
//
//  Created by Przemysław Kuzia on 03/02/2024.
//

import Foundation

import XCTest

@testable import FractalianGraphNavigator

class AcyclicGraphGeneratorTests: XCTestCase {

    func testGenerateGraph() {
        let generator = AcyclicGraphGenerator()

        Task {
            let graph = await generator.generateDAG(
                width: 5,
                height: 5,
                probability: 10
            )

            print(graph)
        }

    }
}

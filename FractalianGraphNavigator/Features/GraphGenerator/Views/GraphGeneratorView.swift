//
//  GraphGeneratorView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 02/02/2024.
//

import SwiftUI

enum GraphType: Int {
    case withCycles, withoutCycles
}

@MainActor
struct GraphGeneratorView: View {

    @Binding var path: NavigationPath

    @EnvironmentObject private var graphManager: GraphManager
    @Environment(\.dismiss) private var dismissAction

    @State private var selectedOption: Int = .zero
    @State private var isLoading: Bool = false
    @State private var isError: Bool = false

    @State private var width: String = .empty
    @State private var height: String = .empty
    @State private var probability: Double = 1.0

    @State private var numberOfNodes: String = .empty
    @State private var maxEdges: String = .empty

    var body: some View {
        ZStack {
            Background()
            VStack(spacing: Spacing.large) {
                Spacer(minLength: Spacing.regular)

                GraphGeneratorFormView(
                    selectedOption: $selectedOption,
                    width: $width,
                    height: $height,
                    probability: $probability,
                    numberOfNodes: $numberOfNodes,
                    maxEdges: $maxEdges
                )

                PrimaryButton(
                    title: .startScreenButtonsGenerate,
                    action: {
                        generateGraph()
                    }
                )
                .padding(
                    EdgeInsets(top: .zero,
                               leading: Spacing.regular,
                               bottom: Spacing.large,
                               trailing: Spacing.regular)
                )
            }
            .padding(.horizontal, Spacing.base)
        }
        .modifier(
            GraphGeneratorViewDestinationsHandler()
        )
        .modifier(
            NavBarTitleModifier(
                title: .graphGeneratorNavBarTitle
            )
        )
        .modifier(
            BackButtonModifier(dismissAction: {
                dismissAction()
            })
        )
        .baseView(
            isLoading: $isLoading,
            isError: $isError
        )
    }

    private func generateGraph() {
        switch GraphType(rawValue: selectedOption) {
        case .withCycles:
            generateCyclicGraph()
        case .withoutCycles:
            generateAcyclicGraph()
        default:
            return
        }
    }

    private func generateCyclicGraph() {
        guard let numberOfNodes = Int(numberOfNodes),
              let maxEdges = Int(maxEdges)
        else { return }

        let generator = RandomGraphGenerator()

        Task(priority: .userInitiated) {
            isLoading = true

            graphManager.graph = await generator.generateGraph(
                nodes: numberOfNodes,
                maxEdgesPerNode: maxEdges
            )

            isLoading = false
            path.append(GraphGeneratorViewDestinations.graphViewer)
        }
    }

    private func generateAcyclicGraph() {
        guard let width = Int(width),
              let height = Int(height)
        else { return }

        let generator = AcyclicGraphGenerator()
        
        Task(priority: .userInitiated) {
            isLoading = true

            graphManager.graph = await generator.generateDAG(
                width: width,
                height: height,
                probability: Int(probability)
            )

            isLoading = false
            path.append(GraphGeneratorViewDestinations.graphViewer)
        }
    }
}

#Preview {
    GraphGeneratorView(
        path: .constant(NavigationPath())
    )
    .environmentObject(GraphManager())
}

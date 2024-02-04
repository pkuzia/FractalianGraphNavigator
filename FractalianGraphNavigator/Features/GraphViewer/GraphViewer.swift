//
//  GraphViewer.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

struct GraphViewer: View {

    @EnvironmentObject private var graphManager: GraphManager
    @Environment(\.dismiss) private var dismissAction

    var body: some View {
        ZStack {
            Background()
            VStack(spacing: Spacing.regular) {
                VStack(alignment: .leading, spacing: Spacing.small) {
                    Spacer(minLength: Spacing.regular)
                    NodeView()
                }

                SecondaryButton(
                    title: String.graphViewerButtonsPrevious, action: {
                        graphManager.restorePreviousGraphNode()
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
            NavBarTitleModifier(
                title: String.graphViewerNavBarTitle
            )
        )
        .modifier(
            BackButtonModifier(dismissAction: {
                dismissAction()
            })
        )
    }
}

private struct NodeView: View {

    @EnvironmentObject private var graphManager: GraphManager

    var body: some View {
        if let activeNode = graphManager.activeNode {
            Text(activeNode.title)
                .style(.headline3)
                .foregroundColor(.textBlack)
                .padding(.horizontal, Spacing.regular)

            if !activeNode.nodes.isEmpty {
                ListView(activeNode: activeNode)
                    .padding(.vertical, Spacing.small)
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                    .background {
                        Color.primaryWhite
                    }
                    .cornerRadius(CornerRadius.regular)
                    .addShadow()
            } else {
                GraphEmptyView()
                    .padding(.vertical, Spacing.small)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        Color.primaryWhite
                    }
                    .cornerRadius(CornerRadius.regular)
                    .addShadow()
            }
        }
    }
}

private struct ListView: View {

    @EnvironmentObject private var graphManager: GraphManager
    var activeNode: GraphViewData

    var body: some View {
        List {
            ForEach(activeNode.nodes, id: \.id) { node in
                GraphNodeView(viewData: node)
                    .onTapGesture {
                        graphManager.selectNewNode(id: node.id)
                    }
                    .onAppear {
                        if node.id == activeNode.nodes.last?.id {
                            graphManager.requestNextPage()
                        }
                    }
            }
            .listRowInsets(.init())
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
    }
}

#Preview {
    GraphViewer()
        .environmentObject(GraphManager())
}

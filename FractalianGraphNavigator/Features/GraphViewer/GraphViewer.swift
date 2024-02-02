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

                    if let activeNode = graphManager.activeNode {
                        Text(activeNode.title)
                            .style(.headline3)
                            .foregroundColor(.textBlack)
                            .padding(.horizontal, Spacing.regular)

                        List {
                            ForEach(activeNode.nodes, id: \.id) { node in
                                GraphNodeView(viewData: node)
                                    .onTapGesture {
                                        print("Tap")
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
                        .padding(.vertical, Spacing.small)
                        .listStyle(.plain)
                        .scrollIndicators(.hidden)
                        .background {
                            Color.primaryWhite
                        }
                        .cornerRadius(10.0)
                        .shadow(
                            color: .backgroundShadow,
                            radius: 8.0
                        )
                    }
                }

                SecondaryButton(
                    title: "Previous folder", action: {}
                )
                .padding(.horizontal, Spacing.regular)

            }
            .padding(.horizontal, Spacing.base)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("XX")
                    .style(.headline3)
                    .foregroundColor(.textBlack)
            }
        }
        .modifier(
            BackButtonModifier(dismissAction: {
                dismissAction()
            })
        )
    }
}

#Preview {
    GraphViewer()
        .environmentObject(GraphManager())
}

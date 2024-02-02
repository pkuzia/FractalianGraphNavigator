//
//  GraphNodeView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 01/02/2024.
//

import SwiftUI

struct GraphNodeView: View {
    @ObservedObject var viewData: GraphNodeViewData

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: Spacing.small) {
                Spacer(minLength: Spacing.medium)

                Text(viewData.title)
                    .style(.headline3)
                    .foregroundColor(.textBlack)
                    .padding(.horizontal, Spacing.regular)

                ListView(
                    nodes: $viewData.nodes,
                    id: $viewData.id
                )

                Spacer()
            }
            .frame(height: 240)
            .background {
                Color.backgroundGreenHue1
            }
            .cornerRadius(CornerRadius.base)
            .padding(.horizontal, Spacing.base)
            .padding(.vertical, Spacing.small)
        }
    }
}

private struct ListView: View {
    @EnvironmentObject private var graphManager: GraphManager
    @Binding var nodes: [GraphInnerNodeViewData]
    @Binding var id: UUID

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: Spacing.base) {
                ForEach($nodes, id: \.id) { node in
                    GraphNodeInnerView(value: node.value)
                        .shadow(
                            color: .backgroundShadow,
                            radius: 8.0
                        )
                        .onAppear {
                            if node.id == nodes.last?.id {
                                graphManager.requestNextInnerPage(for: id)
                            }
                        }
                }
            }
            .padding(.horizontal, Spacing.base)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    GraphNodeView(
        viewData: GraphNodeViewData(
            id: UUID(),
            title: "n1231",
            nodes: [
                GraphInnerNodeViewData(value: "n1"),
                GraphInnerNodeViewData(value: "n2"),
                GraphInnerNodeViewData(value: "n3")
            ])
    )
}

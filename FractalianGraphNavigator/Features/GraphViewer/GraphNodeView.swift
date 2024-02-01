//
//  GraphNodeView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 01/02/2024.
//

import SwiftUI

struct GraphNodeView: View {
    @ObservedObject var viewData: GraphNodeViewData

    var loadNextItems: (() -> Void)

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
                    loadNextItems: loadNextItems
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
    @Binding var nodes: [GraphInnerNodeViewData]

    var loadNextItems: (() -> Void)

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
                                loadNextItems()
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
            title: "n1231",
            nodes: [
                GraphInnerNodeViewData(value: "n1"),
                GraphInnerNodeViewData(value: "n2"),
                GraphInnerNodeViewData(value: "n3")
            ]),
        loadNextItems: {}
    )
}

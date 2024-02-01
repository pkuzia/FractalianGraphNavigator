//
//  GraphViewer.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

struct GraphViewer: View {

    @Environment(\.dismiss) private var dismissAction

    @StateObject var graphViewData = GraphViewData(
        title: "nXX",
        nodes: [
            GraphNodeViewData(
                title: "n1234",
                nodes: [
                    GraphInnerNodeViewData(value: "n997"),
                    GraphInnerNodeViewData(value: "n998"),
                    GraphInnerNodeViewData(value: "n999")
                ]
            ),
            GraphNodeViewData(
                title: "ABC",
                nodes: [
                    GraphInnerNodeViewData(value: "XX"),
                    GraphInnerNodeViewData(value: "YY"),
                    GraphInnerNodeViewData(value: "ZZ")
                ]
            ),
            GraphNodeViewData(
                title: "DVF",
                nodes: [
                    GraphInnerNodeViewData(value: "124"),
                    GraphInnerNodeViewData(value: "n912598"),
                    GraphInnerNodeViewData(value: "7458")
                ]
            )
        ]
    )

    var body: some View {
        ZStack {
            Background()
            VStack(spacing: Spacing.regular) {
                VStack(alignment: .leading, spacing: Spacing.small) {
                    Spacer(minLength: Spacing.large)

                    Text(graphViewData.title)
                        .style(.headline3)
                        .foregroundColor(.textBlack)
                        .padding(.horizontal, Spacing.regular)

                    List {
                        ForEach(graphViewData.nodes, id: \.id) { node in
                            GraphNodeView(viewData: node, loadNextItems: {})
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

                SecondaryButton(
                    title: "Previous folder", action: {}
                )
                .padding(.horizontal, Spacing.regular)

            }
            .padding(.horizontal, Spacing.base)
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
}

//
//  GraphGeneratorFormView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 04/02/2024.
//

import SwiftUI

struct GraphGeneratorFormView: View {
    @Binding var selectedOption: Int

    @Binding var width: String
    @Binding var height: String
    @Binding var probability: Double

    @Binding var numberOfNodes: String
    @Binding var maxEdges: String

    var body: some View {
        VStack(spacing: Spacing.zero) {
            SegmentedControl(
                selectedSegment: $selectedOption,
                title: .graphGeneratorSegementedTitle,
                optionLeft: .graphGeneratorSegementedWithCycles,
                optionRight: .graphGeneratorSegementedWithoutCycles
            )
            .padding(.vertical, Spacing.regular)

            switch GraphType(rawValue: selectedOption) {
            case .withCycles:
                CyclicGraphForm(
                    numberOfNodes: $numberOfNodes,
                    maxEdges: $maxEdges
                )
            case .withoutCycles:
                AcyclicGraphForm(
                    width: $width,
                    height: $height,
                    probability: $probability
                )
            default:
                EmptyView()
            }

            Spacer()
        }
        .padding(.vertical, Spacing.small)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.primaryWhite
        }
        .cornerRadius(CornerRadius.regular)
        .addShadow()
    }
}

private struct AcyclicGraphForm: View {

    @Binding var width: String
    @Binding var height: String
    @Binding var probability: Double

    var body: some View {
        VStack(spacing: Spacing.regular) {
            NumberTextField(
                text: $width,
                title: .graphGeneratorAcyclicWidth,
                placeholder: .graphGeneratorAcyclicWidthPlaceholder
            )

            NumberTextField(
                text: $height,
                title: .graphGeneratorAcyclicHeight,
                placeholder: .graphGeneratorAcyclicHeightPlaceholder
            )

            GraphSliderView(
                sliderValue: $probability,
                title: .graphGeneratorAcyclicProb
            )
        }
    }
}

private struct CyclicGraphForm: View {

    @Binding var numberOfNodes: String
    @Binding var maxEdges: String

    var body: some View {
        VStack(spacing: Spacing.regular) {
            NumberTextField(
                text: $numberOfNodes,
                title: .graphGeneratorRandomNodes,
                placeholder: .graphGeneratorRandomNodesPlaceholder
            )

            NumberTextField(
                text: $maxEdges,
                title: .graphGeneratorRandomEdges,
                placeholder: .graphGeneratorRandomEdgesPlaceholder
            )
        }
    }
}

#Preview {
    GraphGeneratorFormView(
        selectedOption: .constant(1),
        width: .constant(.empty),
        height: .constant(.empty),
        probability: .constant(.zero),
        numberOfNodes: .constant(.empty),
        maxEdges: .constant(.empty))
}

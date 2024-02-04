//
//  GraphSliderView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 02/02/2024.
//

import SwiftUI

struct GraphSliderView: View {
    @Binding var sliderValue: Double

    var title: String

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            Text("\(title): \(Int(sliderValue))%")
                .style(.headline3)
                .foregroundColor(.textBlack)
                .padding(.horizontal, Spacing.base)

            Slider(value: $sliderValue, in: 1...80, step: 1)
                .padding(.horizontal, Spacing.base)
                .accentColor(.primaryGreen)
                .frame(height: 45.0)
        }
    }
}

#Preview {
    GraphSliderView(
        sliderValue: .constant(50),
        title: "Slider"
    )
}

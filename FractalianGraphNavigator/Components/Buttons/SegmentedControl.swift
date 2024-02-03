//
//  SegmentedControl.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 02/02/2024.
//

import SwiftUI

struct SegmentedControl: View {

    @Binding var selectedSegment: Int

    var title: String
    var optionLeft: String
    var optionRight: String

    init(
        selectedSegment: Binding<Int>,
        title: String,
        optionLeft: String,
        optionRight: String
    ) {
        self._selectedSegment = selectedSegment
        self.optionLeft = optionLeft
        self.optionRight = optionRight
        self.title = title

        styleSegmentedControl()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            Text(title)
                .style(.headline3)
                .foregroundColor(.textBlack)
                .padding(.horizontal, Spacing.micro)
            
            Picker(selection: $selectedSegment, label: Text(String.empty)) {
                Text(optionLeft).tag(0)
                Text(optionRight).tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }

    func styleSegmentedControl() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .primaryGreen
        UISegmentedControl.appearance()
            .setTitleTextAttributes([
                .font: TextStyle.body.font,
                .foregroundColor: UIColor.primaryWhite
            ], for: .selected)

        UISegmentedControl.appearance()
            .setTitleTextAttributes([
                .font: TextStyle.body.font,
                .foregroundColor: UIColor.textGray
            ], for: .normal)
    }
}

#Preview {
    SegmentedControl(
        selectedSegment: .constant(0),
        title: "Title",
        optionLeft: "Left",
        optionRight: "Right"
    )
}

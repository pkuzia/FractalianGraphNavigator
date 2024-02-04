//
//  BaseLabelsGroup.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

struct BaseLabelsGroup: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: Spacing.medium) {
            Text(title)
                .style(.headline1)
                .foregroundColor(.textBlack)
                .multilineTextAlignment(.center)

            Text(subtitle)
                .style(.body)
                .foregroundColor(.textGray)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    BaseLabelsGroup(
        title: "Lorem ipsum",
        subtitle: "Integer euismod porttitor feugiat. Donec porttitor accumsan massa vel tincidunt. Aliquam non ullamcorper leo."
    )
}

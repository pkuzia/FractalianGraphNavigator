//
//  GraphNodeInnerView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 01/02/2024.
//

import SwiftUI

struct GraphNodeInnerView: View {
    @Binding var value: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.primaryWhite)
                .frame(width: 96, height: 130)

            Text(value)
                .style(.headline3)
                .foregroundColor(.textBlack)
        }
    }
}

#Preview {
    GraphNodeInnerView(
        value: .constant("n1234")
    )
}

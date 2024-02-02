//
//  GraphEmptyView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 02/02/2024.
//

import SwiftUI

struct GraphEmptyView: View {
    var body: some View {
        Text(String.graphViewerEmptyFolder)
            .style(.body)
            .foregroundColor(.textGray)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    GraphEmptyView()
}

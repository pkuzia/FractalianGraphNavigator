//
//  GraphInnerNodeViewData.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 01/02/2024.
//

import Foundation

class GraphInnerNodeViewData: Identifiable {
    var id = UUID()
    var value: String

    init(
        id: UUID = UUID(),
        value: String
    ) {
        self.id = id
        self.value = value
    }
}

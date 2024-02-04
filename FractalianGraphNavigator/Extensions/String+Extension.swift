//
//  FractalianGraphNavigatorApp.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 27/01/2024.
//

import UIKit

extension String {
    static var empty: String {
        return ""
    }

    var localized: String {
        return NSLocalizedString(
            self,
            tableName: nil,
            bundle: Bundle.main,
            value: .empty,
            comment: .empty
        )
    }
}

//
//  TextStyle.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import UIKit

struct TextStyle {
    let font: UIFont
    let lineSpacing: CGFloat

    public static let body = TextStyle(
        font: FontFamily.Rubik.regular.font(size: 14.0),
        lineSpacing: 6.0
    )

    public static let captionMedium = TextStyle(
        font: FontFamily.Rubik.medium.font(size: 12.0),
        lineSpacing: 1.0
    )

    public static let headline1 = TextStyle(
        font: FontFamily.Rubik.medium.font(size: 28.0),
        lineSpacing: 1.0
    )

    public static let headline2 = TextStyle(
        font: FontFamily.Rubik.medium.font(size: 22.0),
        lineSpacing: 1.0
    )

    public static let headline3 = TextStyle(
        font: FontFamily.Rubik.medium.font(size: 18.0),
        lineSpacing: 1.0
    )
}

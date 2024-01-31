//
//  Background.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

struct Background: View {
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.backgroundBlue)
                    .padding(.horizontal, -Spacing.xxxLarge)
                    .padding(.vertical, -Spacing.xxLarge)
                    .blur(radius: 80.0)
                Spacer()
            }

            Spacer()
            HStack {
                Spacer()
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.backgroundGreenHue2)
                    .padding(.horizontal, -Spacing.xLarge)
                    .padding(.vertical, -Spacing.xxxLarge)
                    .blur(radius: 45.0)
            }
        }
    }
}

#Preview {
    Background()
}

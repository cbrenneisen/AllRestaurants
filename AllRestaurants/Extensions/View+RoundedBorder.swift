//
//  View+RoundedBorder.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/2/22.
//

import SwiftUI

extension View {

    func roundedBorder(
        color: Color,
        radius: CGFloat,
        width: CGFloat
    ) -> some View {
        self
        .overlay(
            RoundedRectangle(cornerRadius: radius)
                .stroke(Color.appColor(.border), lineWidth: width)
        )
        .cornerRadius(radius)
    }
}

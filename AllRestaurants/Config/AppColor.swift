//
//  AppColor.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 3/27/22.
//

import Foundation
import SwiftUI

enum AppColor {

    case background
    case border
    case detail
    case star(filled: Bool)
    case title

    fileprivate var values: ColorValues {
        switch self {
        case .background:
            return .init(r: 248, g: 248, b: 248)
        case .border:
            return .init(r: 230, g: 230, b: 230)
        case .detail:
            return .init(r: 174, g: 174, b: 174)
        case .star(let filled):
            return filled ? .init(r: 240, g: 210, b: 102) : .init(r: 230, g: 230, b: 230)
        case .title:
            return .init(r: 128, g: 128, b: 128)
        }
    }
}

extension Color {

    static func appColor(_ color: AppColor) -> Color {
        let values = color.values
        return Color(
            red: values.red,
            green: values.green,
            blue: values.blue,
            opacity: values.opacity
        )
    }
}

private struct ColorValues {
    let red: Double
    let green: Double
    let blue: Double
    let opacity: Double

    init(r red: Double, g green: Double, b blue: Double, opacity: Double = 1.0) {
        self.red = red / 256
        self.green = green / 256
        self.blue = blue / 256
        self.opacity = opacity
    }
}

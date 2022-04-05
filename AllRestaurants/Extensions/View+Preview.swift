//
//  View+Preview.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/1/22.
//

import SwiftUI

#if DEBUG
struct Preview: ViewModifier {

    enum Device: String {
        case iPhone12 = "iPhone 12"
    }

    var device: Device

    func body(content: Content) -> some View {
        content
            .previewDevice(PreviewDevice(rawValue: device.rawValue))
    }
}

extension View {

    func preview(device: Preview.Device = .iPhone12) -> some View {
        modifier(Preview(device: device))
    }
}
#endif

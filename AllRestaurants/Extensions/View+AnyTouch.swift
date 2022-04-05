//
//  View+AnyTouch.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/5/22.
//

import Foundation
import SwiftUI

extension View {
    func onAnyTouch(callback: @escaping () -> Void) -> some View {
        modifier(OnAnyTouch(action: callback))
    }
}

struct OnAnyTouch: ViewModifier {

    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture()
                    .onChanged { _ in
                        action()
                    } .onEnded { _ in
                        action()
                    }
            )
            .onTapGesture {
                action()
            }
    }
}

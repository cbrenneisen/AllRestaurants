//
//  StateView.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/5/22.
//

import Foundation
import SwiftUI

struct StateView<Content>: View where Content: View {

    let content: Content
    let onRetry: () -> Void
    @Binding var state: ViewState

    public init(state: Binding<ViewState>, onRetry: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._state = state
        self.onRetry = onRetry
    }

    var body: some View {
        content
            .overlay(StateViewOverlay(state: $state, onRetry: onRetry))
    }
}

private struct StateViewOverlay: View {

    @Binding var state: ViewState
    let onRetry: () -> Void

    public init(state: Binding<ViewState>, onRetry: @escaping () -> Void) {
        self._state = state
        self.onRetry = onRetry
    }

    var body: some View {
        VStack {
            switch state {
            case .loading:
                LoadingView()
            case .error(let reason):
                ErrorView(message: reason, onRetry: onRetry)
            case .ready:
                VStack {

                }
            }
        }
    }
}

enum ViewState: Equatable {
    case loading
    case ready
    case error(reason: String)
}

private struct LoadingView: View {

    var body: some View {
        ProgressView()
    }
}

private struct ErrorView: View {

    let message: String
    let onRetry: () -> Void

    var body: some View {
        VStack {
            Text(message)

            Button(action: onRetry) {
                VStack {
                    Text(LocalizedString.retry.value)
                        .foregroundColor(.white)
                        .bold()
                }
                .padding(16)
                .background(Color.green)
                .cornerRadius(8)
            }
        }
    }
}

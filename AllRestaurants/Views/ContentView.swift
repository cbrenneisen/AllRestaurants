//
//  ContentView.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 3/24/22.
//

import SwiftUI
import CoreData
import MapKit

struct ContentView: View {

    enum Screen: Int {
        case list
        case map
    }

    @ObservedObject var viewModel: ContentViewModel
    @Environment(\.contentCoordinator) private var coordinator: ContentCoordinator
    @State var selection: Int = 0

    var body: some View {
        VStack {
            HeaderView()
            StateView(state: $viewModel.state, onRetry: onRetry) {
                ZStack {
                    TabView(selection: $selection) {
                        RestaurantListView(
                            restaurantList: viewModel.restaurantList
                        ).tag(Screen.list.rawValue)

                        RestaurantMapView(
                            restaurantList: $viewModel.restaurantList,
                            region: $viewModel.region
                        )
                        .tag(Screen.map.rawValue)
                    }
                    .frame(maxHeight: .infinity)

                    VStack {
                        Spacer()
                        ToggleButton(screen: Screen(rawValue: selection) ?? .list) {
                            if selection == Screen.map.rawValue {
                                selection = Screen.list.rawValue
                            } else {
                                selection = Screen.map.rawValue
                            }
                        }
                    }.padding(20)
                }
            }
        }
        .onAppear {
            UITabBar.appearance().alpha = 0
            UITabBar.appearance().isHidden = true
        }
    }

    func onRetry() {
        coordinator.retry()
    }
}

private struct ToggleButton: View {

    let screen: ContentView.Screen
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(appIcon: screen.icon)
                    .foregroundColor(.white)
                Text(screen.buttonText.value)
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(16)
            .background(Color.green)
            .cornerRadius(8)
        }
    }
}

private extension ContentView.Screen {
    var icon: AppIcon {
        switch self {
        case .map:
            return .list
        case .list:
            return .map
        }
    }

    var buttonText: LocalizedString {
        switch self {
        case .map:
            return .list
        case .list:
            return .map
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .make())
            .environment(\.contentCoordinator, ContentCoordinatorKey.defaultValue)
            .preview()
    }
}

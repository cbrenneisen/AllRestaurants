//
//  AppFactory.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 3/24/22.
//

import SwiftUI

final class AppFactory {

    func buildOpeningScene() -> some View {
        let viewModel = ContentViewModel(
            restaurantList: [],
            region: .init()
        )
        let coordinator = ContentCoordinator(
            viewModel: viewModel,
            localDataSource: .init(),
            remoteDataSource: .init(),
            restaurantService: RestaurantRemoteService(environment: .development),
            locationManager: LocationManager(),
            persistence: .init()
        )
        coordinator.start()
        return ContentView(viewModel: viewModel)
            .environment(\.contentCoordinator, coordinator)
    }
}


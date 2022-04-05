//
//  EnvironmentKeys.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/2/22.
//

import SwiftUI

struct ContentCoordinatorKey: EnvironmentKey {
    static var defaultValue: ContentCoordinator {
        ContentCoordinator(
            viewModel: .init(restaurantList: [],
                             region: .init()),
            localDataSource: .init(),
            remoteDataSource: .init(),
            restaurantService: RestaurantRemoteService(environment: .development),
            locationManager: LocationManager(),
            persistence: .init()
        )
    }
}

extension EnvironmentValues {
  var contentCoordinator: ContentCoordinator {
    get { self[ContentCoordinatorKey.self] }
    set { self[ContentCoordinatorKey.self] = newValue }
  }
}

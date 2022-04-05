//
//  ContentViewModel.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 3/24/22.
//

import Combine
import CoreLocation
import Foundation
import MapKit
import SwiftUI

class ContentViewModel: ObservableObject {

    @Published var restaurantList: [RestaurantViewModel]
    @Published var region: MKCoordinateRegion
    @Published var state: ViewState

    init(state: ViewState = .loading, restaurantList: [RestaurantViewModel], region: MKCoordinateRegion) {
        self.state = state
        self.restaurantList = restaurantList
        self.region = region
    }
}

#if DEBUG
extension ContentViewModel {

    static func make() -> ContentViewModel {
        return .init(
            restaurantList: .make(),
            region: .init()
        )
    }
}
#endif

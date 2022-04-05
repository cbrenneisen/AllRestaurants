//
//  RestaurantListViewModel.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 3/26/22.
//

import SwiftUI

class RestaurantListViewModel: ObservableObject {

    let list: [RestaurantViewModel]

    init(list: [RestaurantViewModel]) {
        self.list = list
    }
}

#if DEBUG
extension RestaurantListViewModel {

    static func make() -> RestaurantListViewModel {
        return .init(
            list: [
                .make(name: "Heirloom BBQ", rating: 4),
                .make(name: "Casi Cielo", rating: 5),
                .make(name: "The Select", rating: 4),
                .make(name: "Taco Mac", rating: 3)
            ]
        )
    }
}
#endif

//
//  RestaurantViewModel.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 3/26/22.
//

import CoreLocation
import SwiftUI

struct RestaurantViewModel: Identifiable {

    let id: String
    let name: String
    let rating: Int
    let reviewCount: Int
    let priceLevel: PriceLevel
    let favorited: Bool
    let detail: String
    let icon: URL?
    let coordinate: CLLocationCoordinate2D
}

#if DEBUG
extension Array where Element == RestaurantViewModel {

    static func make() -> [RestaurantViewModel] {
        return  [
            .make(name: "Heirloom BBQ", rating: 4),
            .make(name: "Casi Cielo", rating: 5),
            .make(name: "The Select", rating: 4),
            .make(name: "Taco Mac", rating: 3)
        ]
    }
}

extension RestaurantViewModel {

    static func make(
        name: String,
        rating: Int,
        favorited: Bool? = false
    ) -> RestaurantViewModel {
        return .init(
            id: UUID().uuidString,
            name: name,
            rating: rating,
            reviewCount: Int.random(in: 10...1000),
            priceLevel: PriceLevel.allCases.randomElement() ?? .low,
            favorited: favorited ?? (Int.random(in: 0...1) == 1),
            detail: "123 Street",
            icon: URL(string: ""),
            coordinate: .init()
        )
    }
}

#endif

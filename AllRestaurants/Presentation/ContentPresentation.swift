//
//  ContentPresentation.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/2/22.
//

import Foundation
import MapKit

extension ContentViewModel {

    func update(localData: ContentLocalDataSource.Data, remoteData: ContentRemoteDataSource.Data) {
        self.restaurantList = remoteData.restaurants.map {
            RestaurantViewModel(restaurant: $0, localData: localData)
        }
        if let location = localData.location {
            self.region = .init(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        } else {
            self.region = .init()
        }

        if localData.isLoading {
            self.state = .loading
        } else if let error = localData.error {
            self.state = .error(reason: error.value)
        } else {
            self.state = .ready
        }
    }
}

extension RestaurantViewModel {

    init(restaurant: Restaurant, localData: ContentLocalDataSource.Data) {
        self.id = restaurant.id
        self.name = restaurant.name
        self.rating = Int(round(restaurant.rating))
        self.reviewCount = restaurant.reviewTotal
        self.priceLevel = .init(from: restaurant.price)
        self.favorited = localData.favorites.contains(restaurant.id)
        self.detail = restaurant.address
        if let icon = restaurant.icon {
            self.icon = URL(string: icon)
        } else {
            self.icon = nil
        }
        self.coordinate = CLLocationCoordinate2D(
            latitude: Double(restaurant.geometry.location.lat),
            longitude: Double(restaurant.geometry.location.lng)
        )
    }
}

extension PriceLevel {

    init(from num: Int) {
        if num <= 1 {
            self = .low
        } else if num == 2 {
            self = .medium
        } else if num == 3 {
            self = .high
        } else {
            self = .veryHigh
        }
    }
}

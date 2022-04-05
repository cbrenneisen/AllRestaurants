//
//  Restaurant.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/3/22.
//

import Foundation

struct Restaurant: Decodable {

    let id: String
    let address: String
    let geometry: Geometry
    let name: String
    let rating: Double
    let reviewTotal: Int
    let price: Int
    let icon: String?
}

extension Restaurant {
    enum CodingKeys: String, CodingKey {
        case id = "place_id"
        case address = "vicinity"
        case geometry
        case name
        case rating
        case reviewTotal = "user_ratings_total"
        case price = "price_level"
        case icon
    }
}

struct Geometry: Decodable {
    let location: Location
}

struct Location: Decodable {
    let lat: Double
    let lng: Double
}

#if DEBUG

extension Restaurant {

    static func make(name: String, address: String = "") -> Self {
        return .init(
            id: UUID().uuidString,
            address: address,
            geometry: .make(),
            name: name,
            rating: 5,
            reviewTotal: 100,
            price: 2,
            icon: ""
        )
    }
}

extension Geometry {

    static func make() -> Self {
        return .init(location: .init(lat: 0, lng: 0))
    }
}

#endif

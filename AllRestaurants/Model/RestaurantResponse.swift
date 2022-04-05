//
//  RestaurantResponse.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/5/22.
//

import Foundation

struct RestaurantResponse: Decodable {
    let restaurants: [Restaurant]

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        // filter out any results that don't have all required keys
        // (without having the entire object fail decoding)
        let results = try values.decode([Throwable<Restaurant>].self, forKey: .restaurants)
        restaurants = results.compactMap { try? $0.result.get() }
    }
}

extension RestaurantResponse {
    enum CodingKeys: String, CodingKey {
        case restaurants = "results"
    }
}

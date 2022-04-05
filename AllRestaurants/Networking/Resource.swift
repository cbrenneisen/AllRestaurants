//
//  Resource.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/2/22.
//

import Foundation

protocol ResourceType {

    var endpoint: String { get }
    var arguments: [String: String] { get }
}

extension ResourceType {

    func path(using key: String) -> String {
        let argumentString = arguments.merge(additions: ["key": key]).map { key, val in
            "\(key)=\(val)"
        }.joined(separator: "&")
        return "\(endpoint)?\(argumentString)"
    }

    var path: String {
        let argumentString = arguments.map { key, val in
            "\(key)=\(val)"
        }.joined(separator: "&")
        return "\(endpoint)?\(argumentString)"
    }
}

enum RestaurantResource: ResourceType {

    case nearby(filter: String, lat: Double, lon: Double)

    var endpoint: String {
        switch self {
        case .nearby:
            return "maps/api/place/nearbysearch/json"
        }
    }

    var arguments: [String: String] {
        switch self {
        case .nearby(let filter, let lat, let lon):
            let args = [
                "type": "restaurant",
                "radius": "1500",
                "location": "\(lat),\(lon)"
            ]
            if !filter.isEmpty {
                return args.merge(additions: ["keyword": filter])
            } else {
                return args
            }
        }
    }

    private var fields: [String] {
        [
            "place_id",
            "formatted_address",
            "name",
            "rating",
            "opening_hours",
            "geometry",
            "user_ratings_total",
            "price_level",
            "icon"
        ]
    }
}

enum ResourceError: Error {
    case invalidPath
}

extension Dictionary {

    func merge(additions: Self) -> Self {
        return merging(additions, uniquingKeysWith: takeSecond)
    }

    var takeSecond: (Value, Value) -> Value {
        return { _, value2 in
            return value2
        }
    }
}

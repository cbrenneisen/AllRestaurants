//
//  AppConstants.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 3/31/22.
//

import Foundation

// In a bigger app, this would definitely be more robust
struct AppConstants {
    static let starCount = 5
}

enum PriceLevel: Int, CaseIterable {
    case low = 1
    case medium = 2
    case high = 3
    case veryHigh = 4
}

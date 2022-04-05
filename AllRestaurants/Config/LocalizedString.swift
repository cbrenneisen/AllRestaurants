//
//  LocalizedString.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/2/22.
//

import Foundation

enum LocalizedString: String {

    case errorNetwork
    case errorLocation
    case filter
    case list
    case map
    case retry
    case search

    var value: String {
        NSLocalizedString(rawValue, comment: rawValue)
    }
}

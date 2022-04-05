//
//  AppEnvironment.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/3/22.
//

import Foundation

enum AppEnvironment: String {

    case development
    case production

    var baseURL: String {
        switch self {
        case .development:
            return "maps.googleapis.com"
        case .production:
            fatalError("We're not ready to go live!")
        }
    }

    var apiKey: String {
        switch self {
        case .development:
            return "AIzaSyDue_S6t9ybh_NqaeOJDkr1KC9a2ycUYuE"
        case .production:
            fatalError("We're not ready to go live!")
        }
    }
}

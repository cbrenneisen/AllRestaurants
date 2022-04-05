//
//  AppIcon.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 3/27/22.
//

import SwiftUI

enum AppIcon {

    case cancel
    case favorite(Bool)
    case list
    case map
    case search
    case star

    var name: String {
        switch self {
        case .cancel:
            return "x.circle"
        case .favorite(let isFavorited):
            return "heart\(isFavorited ? ".fill" : "")"
        case .list:
            return "list.bullet"
        case .map:
            return "map"
        case .search:
            return "magnifyingglass"
        case .star:
            return "star.fill"
        }
    }
}

extension Image {

    init(appIcon: AppIcon) {
        self = Image(systemName: appIcon.name)
    }
}

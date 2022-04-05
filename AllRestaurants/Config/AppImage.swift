//
//  AppImage.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/1/22.
//

import SwiftUI

enum AppImage: String {

    case placeholder = "martis-trail"
    case logo = "logo"
}

extension Image {

    init(appImage: AppImage) {
        self = Image(appImage.rawValue)
    }
}

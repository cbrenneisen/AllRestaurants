//
//  AllRestaurantsApp.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 3/24/22.
//

import SwiftUI

@main
struct AllRestaurantsApp: App {

    let persistenceController = PersistenceController.shared
    let appFactory = AppFactory()

    var body: some Scene {
        WindowGroup {
            appFactory
                .buildOpeningScene()
        }
    }
}

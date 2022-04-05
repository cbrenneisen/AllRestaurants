//
//  RestaurantPersistence.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/3/22.
//

import Foundation
import SwiftUI

final class RestaurantPersistence {

    enum Key: String {
        case favorites
    }

    var favoritesPublisher: Published<[String]>.Publisher { $favorites }

    @Published private var favorites: [String] = [] {
        didSet {
            sync(object: favorites, key: .favorites)
        }
    }
    private var userDefaults: UserDefaults { .standard }
    private let queue = DispatchQueue(label: "com.allRestaurants.userDefaults")

    init() {
        self.favorites = getObject(key: .favorites) ?? []
    }

    func toggleRestaurant(id: String) {
        write { [weak self] in
            guard let self = self else { return }
            if let index = self.favorites.firstIndex(of: id) {
                self.favorites.remove(at: index)
            } else {
                self.favorites.append(id)
            }
        }
    }

    private func sync<T>(object: T, key: Key) {
        queue.async(flags: .barrier) { [weak self] in
            self?.userDefaults.set(object, forKey: key.rawValue)
        }
    }

    private func write(action: @escaping () -> Void) {
        queue.async(flags: .barrier) {
            action()
        }
    }

    private func getObject<T: Any>(key: Key) -> T? {
        return userDefaults.object(forKey: key.rawValue) as? T
    }
}

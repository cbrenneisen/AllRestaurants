//
//  ContentLocalDataSource.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/2/22.
//

import Combine
import CoreLocation
import Foundation

class ContentLocalDataSource: ObservableObject {

    struct Data {
        fileprivate(set) var searchText: String = ""
        fileprivate(set) var location: CLLocation?
        fileprivate(set) var favorites: [String] = []
        fileprivate(set) var error: LocalizedString?
        fileprivate(set) var isLoading: Bool = true
    }

    @Published var data = Data()
    var dataPublisher: Published<Data>.Publisher { $data }

    func updateSearchText(to searchText: String) {
        data.searchText = searchText
    }

    func updateLocation(to location: CLLocation?) {
        data.location = location
    }

    func updateFavorites(to favorites: [String]) {
        data.favorites = favorites
    }

    func update(loading: Bool = false, error: LocalizedString? = nil) {
        data.isLoading = loading
        data.error = error
    }
}

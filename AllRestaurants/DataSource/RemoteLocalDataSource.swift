//
//  RemoteLocalDataSource.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/2/22.
//

import Combine

class ContentRemoteDataSource: ObservableObject {

    struct Data {
        fileprivate(set) var restaurants: [Restaurant] = []
    }

    @Published var data = Data()
    var dataPublisher: Published<Data>.Publisher { $data }

    func updateRestaurants(to restaurants: [Restaurant]) {
        data.restaurants = restaurants
    }
}

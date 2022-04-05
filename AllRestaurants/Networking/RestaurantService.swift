//
//  RestaurantService.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/5/22.
//

import Combine
import CoreLocation
import Foundation

protocol RestaurantService: AnyObject {

    func getRestaurants(location: CLLocation, filter: String) -> AnyPublisher<[Restaurant], Error>
}

final class RestaurantRemoteService: RemoteService, RestaurantService {

    var session: URLSession {
        URLSession(configuration: .default)
    }

    let environment: AppEnvironment

    init(environment: AppEnvironment) {
        self.environment = environment
    }

    func getRestaurants(location: CLLocation, filter: String) -> AnyPublisher<[Restaurant], Error> {
        let resource = RestaurantResource.nearby(
            filter: filter,
            lat: location.coordinate.latitude,
            lon: location.coordinate.longitude
        )
        return makeRequest(resource: resource).tryMap { data in
            do {
                let response = try JSONDecoder().decode(RestaurantResponse.self, from: data)
                return response.restaurants
            } catch {
                print(error.localizedDescription)
                print(try JSONSerialization.jsonObject(with: data, options: []))
                throw error
            }
        }.eraseToAnyPublisher()
    }
}

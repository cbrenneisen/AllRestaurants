//
//  RemoteService.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/2/22.
//

import Combine
import Foundation
import CoreLocation

protocol RemoteService {

    var session: URLSession { get }

    var environment: AppEnvironment { get }
}

extension RemoteService {

    func makeRequest(resource: ResourceType) -> AnyPublisher<Data, Error> {
        var url: URL
        do {
            url = try getURL(for: resource)
        } catch {
            return Fail<Data, Error>.error(error)
        }

        return session.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                return data
            }.eraseToAnyPublisher()
    }

    private func getURL(for resource: ResourceType) throws -> URL {
        let urlString = [environment.baseURL, resource.path(using: environment.apiKey)]
            .joined(separator: "/")
        guard let url = URL(string: "https://\(urlString)") else {
            throw ResourceError.invalidPath
        }

        return url
    }
}

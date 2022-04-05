//
//  ContentCoordinator.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/2/22.
//

import Combine
import CoreLocation
import SwiftUI

class ContentCoordinator: ObservableObject {

    var searchText: Binding<String> {
        Binding<String>(
            get: { self.localDataSource.data.searchText },
            set: { self.localDataSource.updateSearchText(to: $0) }
        )
    }

    @Published var viewModel: ContentViewModel
    private let localDataSource: ContentLocalDataSource
    private let remoteDataSource: ContentRemoteDataSource
    private let restaurantService: RestaurantService
    private let locationManager: LocationService
    private let persistence: RestaurantPersistence
    private var cancellables = Set<AnyCancellable>()

    init(
        viewModel: ContentViewModel,
        localDataSource: ContentLocalDataSource,
        remoteDataSource: ContentRemoteDataSource,
        restaurantService: RestaurantService,
        locationManager: LocationService,
        persistence: RestaurantPersistence
    ) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
        self.restaurantService = restaurantService
        self.viewModel = viewModel
        self.locationManager = locationManager
        self.persistence = persistence

        setupBindings()
    }

    func start() {
        locationManager.requestLocation()
    }

    func retry() {
        localDataSource.update(loading: true, error: nil)
        if let location = localDataSource.data.location {
            fetchRestaurants(location: location, filter: localDataSource.data.searchText)
        } else {
            locationManager.requestLocation()
        }
    }

    func clearFilter() {
        if let location = locationManager.location.value {
            localDataSource.updateSearchText(to: "")
            fetchRestaurants(location: location)
        } else {
            localDataSource.update(error: .errorLocation)
        }
    }

    func filterRestaurants(using text: String) {
        if let location = localDataSource.data.location {
            fetchRestaurants(location: location, filter: text)
        } else if viewModel.state != .loading {
            localDataSource.update(error: .errorLocation)
        }
    }

    func toggleRestaurant(id: String) {
        persistence.toggleRestaurant(id: id)
    }

    private func setupBindings() {
        Publishers.CombineLatest(
            localDataSource.dataPublisher,
            remoteDataSource.dataPublisher
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: { [weak self] localData, remoteData in
            self?.viewModel.update(localData: localData, remoteData: remoteData)
        }).store(in: &cancellables)

        locationManager
            .location
            .sink { [weak self] location in
                guard let self = self else { return }
                self.localDataSource.updateLocation(to: location)
                if let location = location {
                    self.fetchRestaurants(location: location)
                }
            }.store(in: &cancellables)

        locationManager
            .error
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { error in
                self.localDataSource.update(loading: false, error: .errorLocation)
            }).store(in: &cancellables)

        persistence
            .favoritesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.localDataSource.updateFavorites(to: $0)
            }.store(in: &cancellables)
    }

    private func fetchRestaurants(location: CLLocation, filter: String = "") {
        localDataSource.update(loading: true, error: nil)
        restaurantService
            .getRestaurants(location: location, filter: filter)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] in
                self?.localDataSource.update(loading: false, error: nil)
                self?.remoteDataSource.updateRestaurants(to: $0)
            }).store(in: &cancellables)
    }
}


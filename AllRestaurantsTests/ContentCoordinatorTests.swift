//
//  ContentCoordinatorTests.swift
//  AllRestaurantsTests
//
//  Created by Carl Brenneisen on 4/5/22.
//

import Combine
import MapKit
import XCTest
@testable import AllRestaurants

class ContentCoordinatorTests: XCTestCase {

    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()

        cancellables = Set()
    }

    func testCallLocation() throws {
        let locationManager = MockLocationManager()
        let coordinator = ContentCoordinator(
            viewModel: .make(),
            localDataSource: .init(), remoteDataSource: .init(),
            restaurantService: MockRestaurantService(),
            locationManager: locationManager,
            persistence: .init()
        )

        coordinator.start()
        XCTAssertEqual(locationManager.timesRequestLocationCalled, 1)
    }

    func testFilterRestaurantsWithoutLocation() {
        let restaurantService = MockRestaurantService()
        let localDataSource = ContentLocalDataSource()
        localDataSource.update(loading: false, error: nil)

        let coordinator = ContentCoordinator(
            viewModel: .init(state: .ready, restaurantList: [], region: .init()),
            localDataSource: localDataSource,
            remoteDataSource: .init(),
            restaurantService: restaurantService,
            locationManager: MockLocationManager(),
            persistence: .init()
        )

        coordinator.filterRestaurants(using: "test")
        XCTAssertEqual(localDataSource.data.error, .errorLocation)
    }

    func testFilterRestaurantsWithLocation() {
        let location = CLLocation.init(latitude: 100, longitude: 100)
        let restaurantService = MockRestaurantService()
        let localDataSource = ContentLocalDataSource()
        localDataSource.updateLocation(to: location)

        let coordinator = ContentCoordinator(
            viewModel: .init(state: .ready, restaurantList: [], region: .init()),
            localDataSource: localDataSource,
            remoteDataSource: .init(),
            restaurantService: restaurantService,
            locationManager: MockLocationManager(location: location),
            persistence: .init()
        )

        let exp = expectation(description: "wait for seach call")
        restaurantService
            .searchEvents
            .sink(receiveValue: { event in
                XCTAssertEqual(event, .init(location: location, filter: "test"))
                exp.fulfill()
            }).store(in: &cancellables)

        coordinator.filterRestaurants(using: "test")
        wait(for: [exp], timeout: 1.0)
    }
}

final class MockLocationManager: LocationService {

    var timesRequestLocationCalled = 0
    let location: CurrentValueSubject<CLLocation?, Never>
    let error: PassthroughSubject<LocalizedString, Never>

    init(location: CLLocation? = nil) {
        self.location = CurrentValueSubject<CLLocation?, Never>(location)
        self.error = PassthroughSubject<LocalizedString, Never>()
    }

    func requestLocation() {
        timesRequestLocationCalled += 1
    }
}

final class MockRestaurantService: RestaurantService {

    struct SearchEvent: Equatable {
        let location: CLLocation
        let filter: String
    }

    var searchEvents = PassthroughSubject<SearchEvent, Never>()
    let restaurants = CurrentValueSubject<[Restaurant], Error>([])

    func getRestaurants(location: CLLocation, filter: String) -> AnyPublisher<[Restaurant], Error> {
        DispatchQueue.global().async { [weak self] in
            self?.searchEvents.send(.init(location: location, filter: filter))
        }
        return restaurants.eraseToAnyPublisher()
    }
}

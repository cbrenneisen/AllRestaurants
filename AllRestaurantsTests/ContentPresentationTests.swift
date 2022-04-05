//
//  AllRestaurantsTests.swift
//  AllRestaurantsTests
//
//  Created by Carl Brenneisen on 3/24/22.
//

import MapKit
import XCTest
@testable import AllRestaurants

class ContentPresentationTests: XCTestCase {

    var viewModel: ContentViewModel!

    override func setUp() {
        super.setUp()

        viewModel = ContentViewModel(restaurantList: [], region: .init())
    }

    func testDefault() throws {
        XCTAssertTrue(viewModel.restaurantList.isEmpty)
        XCTAssertEqual(viewModel.region.center.latitude, MKCoordinateRegion().center.latitude)
        XCTAssertEqual(viewModel.region.center.longitude, MKCoordinateRegion().center.longitude)
        XCTAssertEqual(viewModel.state, .loading)
    }

    func testRestaurants() {
        let restaurants: [Restaurant] = [
            .make(name: "Test Restaurant 1"),
            .make(name: "Test Restaurant 2")
        ]
        let remoteData = ContentRemoteDataSource.Data(restaurants: restaurants)
        let localData = ContentLocalDataSource.Data(isLoading: false)
        viewModel.update(localData: localData, remoteData: remoteData)

        XCTAssertEqual(viewModel.state, .ready)
        XCTAssertEqual(viewModel.restaurantList.map{ $0.name }, restaurants.map{ $0.name })
    }

    func testLocation() {
        let remoteData = ContentRemoteDataSource.Data(restaurants: [])
        let localData = ContentLocalDataSource.Data(location: .init(latitude: 100, longitude: 100))
        viewModel.update(localData: localData, remoteData: remoteData)

        XCTAssertEqual(viewModel.region.center.latitude, 100)
        XCTAssertEqual(viewModel.region.center.latitude, 100)
    }

    func testError() {
        let remoteData = ContentRemoteDataSource.Data(restaurants: [])
        let localData = ContentLocalDataSource.Data(error: .errorLocation, isLoading: false)
        viewModel.update(localData: localData, remoteData: remoteData)

        switch viewModel.state {
        case .error(let reason):
            XCTAssertEqual(localData.error?.value, reason)
        default:
            XCTFail("Wrong viewModel state")
        }
    }
}


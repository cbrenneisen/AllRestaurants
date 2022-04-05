//
//  LocationManager.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/3/22.
//

import Combine
import CoreLocation
import Foundation

protocol LocationService: AnyObject {

    var error: PassthroughSubject<LocalizedString, Never> { get }
    var location: CurrentValueSubject<CLLocation?, Never> { get }
    func requestLocation()
}

class LocationManager: NSObject, LocationService, CLLocationManagerDelegate {

    private var authStatus: CLAuthorizationStatus { locationManager.authorizationStatus }
    private var locationManager: CLLocationManager!
    let location = CurrentValueSubject<CLLocation?, Never>(nil)
    let error = PassthroughSubject<LocalizedString, Never>()

    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self

        //TODO: - handle errors
    }

    func requestLocation() {
        switch authStatus {
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            getManagerLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        setLocation(to: nil)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        setLocation(to: locations.last)
    }

    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        getManagerLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch authStatus {
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            getManagerLocation()
        case .notDetermined:
            break
        case .restricted, .denied:
            setLocation(to: nil)
        @unknown default:
            setLocation(to: nil)
        }
    }

    private func getManagerLocation() {
        if locationManager.location != nil {
            setLocation(to: locationManager.location)
        } else {
            locationManager.requestLocation()
        }
    }

    private func setLocation(to location: CLLocation?) {
        if location == nil {
            error.send(.errorLocation)
        }
        self.location.send(locationManager.location)
    }
}

//
//  CLLocationCoordinate2D.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/3/22.
//

import CoreLocation
import Foundation

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

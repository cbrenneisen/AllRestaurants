//
//  Fail+Error.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/2/22.
//

import Combine
import Foundation

extension Fail {

    static func error<T, U: Error>(_ error: U) -> AnyPublisher<T, U> {
        return Fail<T, U>(error: error).eraseToAnyPublisher()
    }
}

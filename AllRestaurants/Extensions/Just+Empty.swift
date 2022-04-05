//
//  Just+Empty.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/3/22.
//

import Foundation
import Combine

extension Just {

    static func empty<T: Error>() -> AnyPublisher<Void, T> {
        return Just<Void>(()).complete()
    }

    func complete<T: Error>() -> AnyPublisher<Output, T> {
        return setFailureType(to: T.self).eraseToAnyPublisher()
    }
}

//
//  Throwable.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/5/22.
//

import Foundation

struct Throwable<T: Decodable>: Decodable {
    let result: Result<T, Error>

    init(from decoder: Decoder) throws {
        result = Result(catching: { try T(from: decoder) })
    }
}

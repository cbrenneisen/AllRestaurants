//
//  AppEndpoints.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/2/22.
//

import Foundation

//protocol AppEndpoints {
//
//    func getURL(for resource: ResourceType) throws -> URL
//}
//
//final class RemoteEndpoints: AppEndpoints {
//
//    var baseURL: String {
//        return environment.rawValue
//    }
//
//    private let environment: AppEnvironment
//    private let apiKey = "AIzaSyDue_S6t9ybh_NqaeOJDkr1KC9a2ycUYuE"
//
//    init(environment: AppEnvironment) {
//        self.environment = environment
//    }
//
//    func getURL(for resource: ResourceType) throws -> URL {
//        let urlString = [baseURL, resource.path].joined(separator: "/")
//        guard let url = URL(string: "https://\(urlString)") else {
//            throw ResourceError.invalidPath
//        }
//
//        return url
//    }
//}

/*
"maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&input=mongolian&inputtype=textquery&locationbias=circle%3A2000%4047.6918452%2C-122.2226413&key="
*/


//{
//   "candidates" : [
//      {
//         "formatted_address" : "9738 NE 117th Ln ste c, Kirkland, WA 98034, United States",
//         "geometry" : {
//            "location" : {
//               "lat" : 47.7057677,
//               "lng" : -122.2111481
//            },
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 47.70711752989273,
//                  "lng" : -122.2097982701073
//               },
//               "southwest" : {
//                  "lat" : 47.70441787010729,
//                  "lng" : -122.2124979298927
//               }
//            }
//         },
//         "name" : "Mongolian Grill Kirkland",
//         "opening_hours" : {
//            "open_now" : true
//         },
//         "rating" : 4.5
//      }
//   ],
//   "status" : "OK"
//}

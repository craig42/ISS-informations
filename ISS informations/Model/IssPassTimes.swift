//
//  IssPassTimes.swift
//  ISS informations
//
//  Created by Craig Josse on 26/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation

struct IssPassTimes: Codable {
    let message: String
    let request: Request
    let response: [Response]
}

struct Request: Codable {
    let altitude, datetime: Int
    let latitude, longitude: Double
    let passes: Int
}

struct Response: Codable {
    let duration, risetime: Int
}

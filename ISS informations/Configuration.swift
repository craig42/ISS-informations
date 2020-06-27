//
//  Configuration.swift
//  ISS informations
//
//  Created by Craig Josse on 26/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation

enum StatusCode: Int {
    case success = 0, error, notUpdated, locationProblem, alreadyUpdated, connectionProblem
}

struct Configuration {
    static let scheme = "http"
    static let httpMethod = "GET"
    static let host = "api.open-notify.org"
    static let port = 80
    static let slash = "/"
}

struct IssData {
    static let issPosition = "iss-now.json"
    static let peopleInSpace = "astros.json"
    static let issPass = "iss-pass.json"
}

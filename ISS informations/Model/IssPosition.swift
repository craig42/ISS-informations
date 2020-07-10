//
//  IssPosition.swift
//  ISS informations
//
//  Created by Craig Josse on 26/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation

// MARK: - IssJSONPosition
struct IssJSONPosition: Codable {
    let message: String
    let timestamp: Int
    let issPosition: IssPosition

    enum CodingKeys: String, CodingKey {
        case message, timestamp
        case issPosition
    }
}

// MARK: - IssPosition
struct IssPosition: Codable {
    let longitude, latitude: String
}

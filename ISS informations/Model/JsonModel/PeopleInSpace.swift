//
//  NumberPeopleInSpace.swift
//  ISS informations
//
//  Created by Craig Josse on 26/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation

struct PeopleInSpace: Codable {
    let message: String
    let number: Int
    let people: [Person]
}

struct Person: Codable {
    let craft, name: String
}


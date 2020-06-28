//
//  IssLocation.swift
//  ISS informationsTests
//
//  Created by Craig Josse on 28/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import XCTest
@testable import ISS_informations
import CoreLocation

class UserLocation: XCTestCase {
    var userLocation: CLLocationCoordinate2D?
    enum MyError: Error {
        case first(message: String)
        case second(message: String)
    }
    func testLocation() {
        let locationManager = CLLocationManager()
        let locationServices = LocationServices()
        locationServices.run(callback: locationCallback(location:))
        locationServices.locationManager(locationManager, didFailWithError: MyError.first(message: "test"))
        XCTAssert(userLocation == nil)
    }
    func locationCallback(location: CLLocation?) {
        if let location = location {
            userLocation?.latitude = location.coordinate.latitude
            userLocation?.longitude = location.coordinate.longitude
        } else {
            userLocation = nil
        }
    }

}

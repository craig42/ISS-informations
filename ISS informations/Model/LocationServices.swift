//
//  LocationServices.swift
//  ISS informations
//
//  Created by Craig Josse on 26/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import CoreLocation

class LocationServices: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var locationCallback: ((CLLocation?) -> Void)?
    var locationServicesEnabled = false
    var didFailWithError: Error?
    func run(callback: @escaping (CLLocation?) -> Void) {
        locationCallback = callback
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestWhenInUseAuthorization()
        locationServicesEnabled = CLLocationManager.locationServicesEnabled()
        if locationServicesEnabled {
            manager.startUpdatingLocation()
        } else {
            if let locationCallback = locationCallback {
                locationCallback(nil)
            }
        }
    }
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let locationCallback = locationCallback {
            locationCallback(locations.last)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFailWithError = error
        if let locationCallback = locationCallback {
            locationCallback(nil)
        }
        manager.stopUpdatingLocation()
    }
}

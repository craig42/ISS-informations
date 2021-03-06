//
//  IssPassTimesToView.swift
//  ISS informations
//
//  Created by Craig Josse on 26/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import CoreLocation

class IssPassTimesToView {
    let locationServices = LocationServices()
    var userLocation = CLLocationCoordinate2D() {
        didSet {
            if isCorrectLocation && callIssPassTimes {
                if let issPassTimeCallback = issPassTimeCallback {
                    getIssPassTimesWhenLocation(callback: issPassTimeCallback)
                }
            }
        }
    }
    var issPassTimeCallback: ((String) -> Void)?
    var callIssPassTimes = false
    var textToDisplay = ""
    var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
    var isCorrectLocation: Bool { return userLocation.longitude != 0.0 && userLocation.latitude != 0.0 }
    func getIssPassTimes(callback : @escaping (String) -> Void) {
        startLocationServices()
        callIssPassTimes = true
        issPassTimeCallback = callback
    }
    func getIssPassTimesWhenLocation (callback : @escaping (String) -> Void) {
        self.callIssPassTimes = false
        let httpService = HttpService<IssPassTimes>()
        var param = [String: String]()
        param["lat"] = String(userLocation.latitude)
        param["lon"] = String(userLocation.longitude)
        httpService.getIssData(for: Endpoints.issPass, param: param, callback: { statusCode in
            if statusCode == StatusCode.success {
                if let data = httpService.data {
                    self.textToDisplay = "There is \(data.request.passes) passes : \n"
                    for response in data.response {
                        self.textToDisplay += "at \(self.formatDate(response.risetime)) "
                        self.textToDisplay += "while \(response.duration) seconds\n"
                    }
                    self.textToDisplay.removeLast()
                    callback(self.textToDisplay)
                }
            }
        })
    }
    func startLocationServices () {
        locationServices.run(callback: locationCallback(location:))
    }
    func locationCallback (location: CLLocation?) {
        if let location = location {
            userLocation.latitude = location.coordinate.latitude
            userLocation.longitude = location.coordinate.longitude
        }
    }
    func formatDate(_ unixDate: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = DateComponentsFormatter.UnitsStyle.full

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: localTimeZoneAbbreviation)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = Date(timeIntervalSince1970: Double(unixDate))
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}

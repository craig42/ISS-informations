//
//  IssPosition.swift
//  ISS informations
//
//  Created by Craig Josse on 26/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import MapKit

class IssPositionToView {
    var coordinate = CLLocationCoordinate2D()
    func getIssPosition(callback : @escaping (CLLocationCoordinate2D) -> Void) {
        let httpService = HttpService<IssJSONPosition>()
        httpService.getIssData(forData: IssData.issPosition, param: nil, callback: { statusCode in
            if statusCode == StatusCode.success {
                let data = httpService.data
                if let latitude = data?.issPosition.latitude,
                    let longitude = data?.issPosition.longitude,
                    let latitudeD = Double(latitude),
                    let longitudeD = Double(longitude) {
                    self.coordinate.latitude = latitudeD
                    self.coordinate.longitude = longitudeD
                    if CLLocationCoordinate2DIsValid(self.coordinate) {
                        callback(self.coordinate)
                    }
                }
            }
        })
    }
}

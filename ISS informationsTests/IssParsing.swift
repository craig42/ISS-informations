//
//  IssParsing.swift
//  ISS informationsTests
//
//  Created by Craig Josse on 28/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import XCTest
@testable import ISS_informations
import CoreLocation

class IssParsing: XCTestCase {
    func testIssDataPassTimes() {
        let expectation = self.expectation(description: "Iss data pass times")
        let userLocation = CLLocationCoordinate2D(latitude: 44.8417, longitude: -0.5814)
        let httpService = HttpService<IssPassTimes>()
        var param = [String: String]()
        param["lat"] = String(userLocation.latitude)
        param["lon"] = String(userLocation.longitude)
        httpService.getIssData(for: Endpoints.issPass, param: param, callback: { statusCode in
            XCTAssert(statusCode == StatusCode.success)
            if let data = httpService.data {
                XCTAssert(data.message.contains("success"))
                XCTAssert(data.request.latitude == userLocation.latitude)
                XCTAssert(data.request.longitude == userLocation.longitude)
                XCTAssert(data.response.count > 2)
                for response in data.response {
                    XCTAssert(response.risetime > 1593358471)
                    XCTAssert(response.duration > 0)
                }
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testNumberPeopleDataTimes() {
        let expectation = self.expectation(description: "People data")
        let httpService = HttpService<PeopleInSpace>()
        httpService.getIssData(for: Endpoints.peopleInSpace, param: nil, callback: { statusCode in
            XCTAssert(statusCode == StatusCode.success)
            if let data = httpService.data {
                XCTAssert(data.message.contains("success"))
                XCTAssert(data.number > 1)
                for people in data.people {
                    XCTAssert(people.name.count > 3)
                    XCTAssert(people.craft.count > 1)
                }
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testIssDataPosition() {
        let expectation = self.expectation(description: "People data")
        let httpService = HttpService<IssJSONPosition>()
        httpService.getIssData(for: Endpoints.issPosition, param: nil, callback: { statusCode in
            XCTAssert(statusCode == StatusCode.success)
            if let data = httpService.data {
                XCTAssert(data.message.contains("success"))
                XCTAssert(Double(data.timestamp) <= NSDate().timeIntervalSince1970)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }

}

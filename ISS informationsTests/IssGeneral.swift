//
//  IssPositionTests.swift
//  ISS informationsTests
//
//  Created by Craig Josse on 27/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ISS_informations

class IssGeneral: XCTestCase {
    func testIssPosition () {
        let expectation = self.expectation(description: "Iss position")
        let issPosition = IssPositionToView()
        issPosition.getIssPosition(callback: { coordinate in
            XCTAssert(CLLocationCoordinate2DIsValid(coordinate))
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testPeopleInSpace () {
        let expectation = self.expectation(description: "People in space")
        let peopleInSpace = PeopleInSpaceToView()
        peopleInSpace.getPeopleInSpace(callback: { peopleText in
            let lines = peopleText.components(separatedBy: "\n")
            XCTAssert(lines.count > 2)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testIssPassTimes () {
        let expectation = self.expectation(description: "Iss pass times")
        let issPassTimes = IssPassTimesToView()
        issPassTimes.getIssPassTimes(callback: { issPassTimes in
            let lines = issPassTimes.components(separatedBy: "\n")
            XCTAssert(lines.count > 2)
            expectation.fulfill()
        })
         issPassTimes.userLocation = CLLocationCoordinate2D(latitude: 44.8417, longitude: -0.5814)
        waitForExpectations(timeout: 5, handler: nil)
    }
}

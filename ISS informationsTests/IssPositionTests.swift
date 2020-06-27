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

class IssPositionTests: XCTestCase {
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
        peopleInSpace.getPeopleInSpace(callback: { peopleText, numberOfLines in
            let lines = peopleText.components(separatedBy: "\n")
            XCTAssert(lines.count == numberOfLines)
            XCTAssert(numberOfLines > 2)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}

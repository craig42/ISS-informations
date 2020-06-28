//
//  Http.swift
//  ISS informationsTests
//
//  Created by Craig Josse on 28/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import XCTest
@testable import ISS_informations

class Http: XCTestCase {

    func testHttpError() {
        let expectation = self.expectation(description: "Http error")

        let httpService = HttpService<IssPosition>()
        httpService.getIssData(for: "whatever", param: nil, callback: { statusCode in
            XCTAssert(statusCode == StatusCode.error)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testErrorParsing() {
        let expectation = self.expectation(description: "Error parsing")

        let httpService = HttpService<IssPosition>()
        httpService.getIssData(for: Endpoints.peopleInSpace, param: nil, callback: { statusCode in
            XCTAssert(statusCode == StatusCode.error)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }

}

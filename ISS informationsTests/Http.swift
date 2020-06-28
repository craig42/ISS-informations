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
    func testGetHttp() {
        let expectation = self.expectation(description: "get http")
        let url = Http.makeURL(path: Endpoints.issPass, dict: nil)
        if let url = url {
            HttpRequest.getHttp(url: url, body: "", callback: { _, error, statusCode in
                XCTAssert(statusCode == StatusCode.error)
                XCTAssert(error.contains("The request timed out"))
                expectation.fulfill()
            })
        } else {
            XCTFail("URL doesn't exist")
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
    static func makeURL(path: String, dict: [String: String]?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Configuration.scheme
        urlComponents.host = "whatever.lol"
        urlComponents.port = 4242
        urlComponents.path = "/" + Endpoints.issPass
        urlComponents.queryItems = []
        return urlComponents.url
    }
}

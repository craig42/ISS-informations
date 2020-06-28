//
//  IssStructure.swift
//  ISS informationsTests
//
//  Created by Craig Josse on 28/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import XCTest
@testable import ISS_informations

class IssStructure: XCTestCase {
    func openFile(for ressource: String) -> Data {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: ressource, ofType: "json") else {
            fatalError()
        }
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError()
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError()
        }
        return jsonData
    }
    func testIssPosition() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let jsonData = openFile(for: "SampleIssNow")
        do {
            let issPosition = try decoder.decode(IssJSONPosition.self, from: jsonData)
            XCTAssert(issPosition.message == "success")
            XCTAssert(issPosition.timestamp == 1593276870)
            XCTAssert(issPosition.issPosition.longitude == "-9.2654")
            XCTAssert(issPosition.issPosition.latitude == "-41.3625")
        } catch {
            XCTFail("\(error)")
        }
    }
    func testIssPassTimes() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let jsonData = openFile(for: "SampleIssPassTimes")
        do {
            let issPass = try decoder.decode(IssPassTimes.self, from: jsonData)
            XCTAssert(issPass.message == "success")
            XCTAssert(issPass.request.altitude == 100)
            XCTAssert(issPass.request.datetime == 1593276734)
            XCTAssert(issPass.request.latitude == 45.632081177076074)
            XCTAssert(issPass.request.longitude == -1.0395748409162304)
            XCTAssert(issPass.request.passes == 5)
            XCTAssert(issPass.response[0].duration == 526)
            XCTAssert(issPass.response[0].risetime == 1593312716)
        } catch {
            XCTFail("\(error)")
        }
    }
    func testPeopleInSpace() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let jsonData = openFile(for: "SamplePeopleInSpace")
        do {
            let peopleInSpace = try decoder.decode(PeopleInSpace.self, from: jsonData)
            XCTAssert(peopleInSpace.message == "success")
            XCTAssert(peopleInSpace.number == 5)
            XCTAssert(peopleInSpace.people[0].craft == "ISS")
            XCTAssert(peopleInSpace.people[0].name == "Chris Cassidy")
        } catch {
            XCTFail("\(error)")
        }
    }
}

//
//  ISS_informationsUITests.swift
//  ISS informationsUITests
//
//  Created by Craig Josse on 26/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import XCTest

class IssInformationsUITests: XCTestCase {
    var app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
        app.launch()
    }

    func testStaticLabel() throws {
        XCTAssert(app.staticTexts["ISS informations"].exists)
        XCTAssert(app.staticTexts["Where is ISS ?"].exists)
        XCTAssert(app.staticTexts["How many people are in space ?"].exists)
        XCTAssert(app.staticTexts["Upcoming ISS passes next to your location"].exists)
    }
    func testMapKitAnnotation() throws {
        let annotation = app.maps.element.otherElements["ISS"]
        print("Annotation \(annotation.debugDescription)")
        annotation.tap()
        XCTAssert(app.maps.element.otherElements["ISS"].exists)
    }
    func testDynamicLabel() throws {
        XCTAssertFalse(app.staticTexts["..."].exists)
    }
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

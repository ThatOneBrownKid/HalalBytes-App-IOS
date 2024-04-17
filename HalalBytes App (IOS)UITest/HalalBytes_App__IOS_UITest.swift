//
//  HalalBytes_App__IOS_UITest.swift
//  HalalBytes App (IOS)UITest
//
//  Created by Shafin Alam on 4/15/24.
//

import XCTest

final class HalalBytes_App__IOS_UITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testViewingFirstRestaurantDetails() {
        let app = XCUIApplication()
        app.launch()
        
        // Wait for the first restaurant cell to appear
        let firstRestaurantCell = app.tables.cells.element(boundBy: 0)
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: firstRestaurantCell, handler: nil)
        waitForExpectations(timeout: 10, handler: nil) // Adjust timeout as needed
        
        // Tap on the first restaurant cell
        firstRestaurantCell.tap()
        
        // Check if the restaurant details view is displayed
        let detailsView = app.otherElements["RestDetailView"]
        XCTAssertTrue(detailsView.exists, "Restaurant details view should be displayed after tapping the first restaurant.")
    }

//    func testViewingRestaurantDetails() {
//        let app = XCUIApplication()
//        app.launch()
//        
//        // Ensure the list loads by adding a static text check or similar
//        let exists = NSPredicate(format: "exists == true")
//        
//        expectation(for: exists, evaluatedWith: app.cells.matching(identifier: "restaurantCell").firstMatch, handler: nil)
//        waitForExpectations(timeout: 30, handler: nil)
//        
//        let firstRestaurantCell = app.cells.matching(identifier: "restaurantCell").firstMatch
//        if firstRestaurantCell.exists {
//            firstRestaurantCell.tap()
//            XCTAssertTrue(app.otherElements["RestDetailView"].exists, "Restaurant details view should be displayed after tapping a restaurant")
//        } else {
//            XCTFail("No restaurant cells exist to tap on.")
//        }
//    }

}

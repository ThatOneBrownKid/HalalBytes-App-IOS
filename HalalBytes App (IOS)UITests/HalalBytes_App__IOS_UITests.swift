//
//  HalalBytes_App__IOS_UITests.swift
//  HalalBytes App (IOS)UITests
//
//  Created by Shafin Alam on 4/15/24.
//

import XCTest
@testable import HalalBytes_App__IOS_

final class HalalBytes_App__IOS_UITests: XCTestCase {

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
    
//    func testOpeningRestCreateView() {
//        let app = XCUIApplication()
//        app.launch()
//
//        let addRestaurantButton = app.buttons["addRestaurant"]
//        XCTAssertTrue(addRestaurantButton.exists, "There should be a button to add a new restaurant.")
//        
//        addRestaurantButton.tap()
//        XCTAssertTrue(app.otherElements["RestCreateView"].exists, "The restaurant creation view should be present.")
//    }
//
//    func testAddingRestaurant() {
//        let app = XCUIApplication()
//        app.launch()
//
//        app.buttons["addRestaurant"].tap()
//        
//        let nameTextField = app.textFields["name"]
//        nameTextField.tap()
//        nameTextField.typeText("Test Restaurant")
//        
//        let cuisineTextField = app.textFields["cuisine"]
//        cuisineTextField.tap()
//        cuisineTextField.typeText("Test Cuisine")
//        
//        app.buttons["saveRestaurant"].tap()
//        XCTAssertTrue(app.staticTexts["Test Restaurant"].exists, "The new restaurant should be visible in the list.")
//    }
//
//    func testViewingRestaurantDetails() {
//        let app = XCUIApplication()
//        app.launch()
//        
//        let firstRestaurantCell = app.cells["RestaurantCell"].firstMatch
//        if firstRestaurantCell.waitForExistence(timeout: 5) {
//            firstRestaurantCell.tap()
//            XCTAssertTrue(app.otherElements["RestDetailView"].exists, "Restaurant details view should be displayed.")
//        } else {
//            XCTFail("The restaurant list is not loading or is empty.")
//        }
//    }

}

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

//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testViewingRestaurantList() {
        let app = XCUIApplication()
        app.launch()
        
        // Wait for the list view to load and check if it exists
        let listView = app.otherElements["RestListView"]
        XCTAssertTrue(listView.waitForExistence(timeout: 10), "The restaurant list view should be visible.")
    }

    func testViewingRestaurantCreate() {
        let app = XCUIApplication()
        app.launch()
        
        // Wait for the list view to load and check if it exists
        let listView = app.otherElements["RestCreateView"]
        XCTAssertTrue(listView.waitForExistence(timeout: 30), "The restaurant create view should be visible.")
    }

//    func testMapViewAccessibility() {
//        let app = XCUIApplication()
//        app.launch()
//
//        // Access the map tab using its accessibility identifier and tap it
//        let mapTab = app.tabBars.buttons["mapTab"]
//        XCTAssertTrue(mapTab.exists, "The map tab should be visible on the screen")
//        mapTab.tap()
//
//        // Wait for the map view to appear
//        let mapView = app.otherElements["RestaurantsMapView"]
//        let exists = mapView.waitForExistence(timeout: 10) // Adjust timeout as needed based on network speed and response time
//
//        XCTAssertTrue(exists, "RestaurantsMapView should be displayed after tapping the map tab")
//    }
//    
//    func testMapViewOpening() {
//        let app = XCUIApplication()
//        app.launch()
//
//        // Print the current UI hierarchy
//        print(app.debugDescription)
//
//        let mapTab = app.tabBars.buttons["mapTab"]
//        XCTAssertTrue(mapTab.exists, "The map tab should be visible on the screen")
//        mapTab.tap()
//
//        let mapView = app.otherElements["RestaurantsMapView"]
//        XCTAssertTrue(mapView.exists, "RestaurantsMapView should be displayed after tapping the map tab")
//    }

}

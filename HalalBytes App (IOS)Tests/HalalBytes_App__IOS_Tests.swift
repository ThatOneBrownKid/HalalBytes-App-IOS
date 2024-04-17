//
//  HalalBytes_App__IOS_Tests.swift
//  HalalBytes App (IOS)Tests
//
//  Created by Shafin Alam on 4/15/24.
//

import XCTest
@testable import HalalBytes_App__IOS_


final class HalalBytes_App__IOS_Tests: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageUploadValidation() {
        let viewModel = RestViewModel() // Make sure that viewModel is properly initialized for testing.

        // Create a dummy image.
        let dummyImage = UIImage(systemName: "photo")!
        XCTAssertNotNil(dummyImage, "Dummy image should not be nil")
        
        let expectation = self.expectation(description: "Upload should succeed with dummy image data")
        viewModel.uploadImage(image: dummyImage) { url in
            // If your method properly handles the upload and calls the completion with a URL, assert for a non-nil value.
            // If it's supposed to fail and return nil, then assert for nil.
            // Adjust the XCTAssert accordingly.
            XCTAssertNotNil(url, "URL should not be nil for valid image data")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }



    func testRestaurantCreationWithInvalidData() {
        let viewModel = RestViewModel()
        // Use appropriate dummy data that represents an invalid restaurant
        // Since latitude and longitude are non-optional Double values, provide dummy data
        let invalidRestaurant = Restaurant(id: UUID().uuidString, name: "", cuisine: "", phone: "", street_address: "", city: "", state: "", zip_code: "", latitude: 0.0, longitude: 0.0, imageUrls: [])

        let expectation = self.expectation(description: "Restaurant creation should fail with invalid data")
        
        // Attempt to create a restaurant with the invalid data
        viewModel.createRestaurant(restaurant: invalidRestaurant, images: []) { success, errorMessage in
            // We expect failure, so success should be false
            XCTAssertFalse(success, "Restaurant creation should have failed.")
            
            // Since the data is invalid, we also expect an error message
            XCTAssertNotNil(errorMessage, "There should be an error message for invalid restaurant data.")
            
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }


    
    func testGeocodeAddress() {
        let viewModel = RestViewModel()
        let validAddress = "1600 Pennsylvania Ave NW, Washington, DC 20500"

        let expectation = self.expectation(description: "Geocode should succeed for a valid address")
        viewModel.geocodeAddress(validAddress) { coordinate in
            XCTAssertNotNil(coordinate, "Geocode should not be nil for a valid address")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10.0, handler: nil) // Geocoding might take longer due to network delay
    }


}

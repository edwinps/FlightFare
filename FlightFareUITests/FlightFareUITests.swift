//
//  FlightFareUITests.swift
//  FlightFareUITests
//
//  Created by Edwin Peña Sanchez 
//

import XCTest

final class FlightFareUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
    }
    
    func testRouteView_success() throws {
        let departureTextField = app.textFields["Departure City"]
        let destinationTextField = app.textFields["Destination City"]
        let calculateButton = app.buttons["Calculate Route"]
        let showRouteOnMapButton = app.buttons["Show Route on Map"]
        
        departureTextField.tap()
        departureTextField.typeText("L")
        departureTextField.typeText("o")
        departureTextField.typeText("n")
        departureTextField.typeText("d")
        departureTextField.typeText("o")
        departureTextField.typeText("n")
        
        destinationTextField.tap()
        destinationTextField.typeText("T")
        destinationTextField.typeText("o")
        destinationTextField.typeText("k")
        destinationTextField.typeText("y")
        destinationTextField.typeText("o")
        destinationTextField.typeText("Tokyo")
        
        calculateButton.tap()
        
        XCTAssertTrue(app.staticTexts["Selected Route:"].exists)
        XCTAssertTrue(app.staticTexts["London to Tokyo - 220"].exists)
        XCTAssertTrue(app.staticTexts["Total Price: 220"].exists)
        
        showRouteOnMapButton.tap()
        let mapView = app.maps.element
        XCTAssertTrue(mapView.waitForExistence(timeout: 5))
        
        app.buttons["X"].tap()
        XCTAssertTrue(app.staticTexts["Selected Route:"].exists)
    }
    
    func testRouteView_Failure() throws {
        let departureTextField = app.textFields["Departure City"]
        let destinationTextField = app.textFields["Destination City"]
        let calculateButton = app.buttons["Calculate Route"]
        departureTextField.tap()
        departureTextField.typeText("CityA")
        destinationTextField.tap()
        destinationTextField.typeText("CityB")
        
        calculateButton.tap()
        
        XCTAssertTrue(app.alerts["Error"].exists)
        XCTAssertTrue(app.staticTexts["There are no routes for the selected cities"].exists)
    }
}

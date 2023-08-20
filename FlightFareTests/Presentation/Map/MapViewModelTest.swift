//
//  MapViewModelTest.swift
//  FlightFareTests
//
//  Created by Edwin Peña Sanchez 
//

import XCTest
import MapKit
@testable import FlightFare

class MapViewModelTests: XCTestCase {
    var viewModel: MapViewModel!
    var connections: [Connection]!
    
    override func setUp() {
        super.setUp()
        connections = MockModels.connections
        viewModel = MapViewModel(selectedRoute: connections)
    }
    
    override func tearDown() {
        super.tearDown()
        connections = []
        viewModel = nil
    }
    
    func testMapViewModelInitialization() {
        XCTAssertEqual(viewModel.centerCoordinate.latitude, 1)
        XCTAssertEqual(viewModel.centerCoordinate.longitude, -1)
        XCTAssertEqual(viewModel.annotations.count, 4)
        XCTAssertEqual(viewModel.routePolylines.count, 2)
    }
    
    func testCalculateCenterCoordinateWithNoRoutes() {
        let emptyRoutes: [Connection] = []
        let mapViewModel = MapViewModel(selectedRoute: emptyRoutes)
        
        let centerCoordinate = mapViewModel.centerCoordinate
        
        XCTAssertEqual(centerCoordinate.latitude, 0)
        XCTAssertEqual(centerCoordinate.longitude, 0)
    }
    
    func testCreateMapAnnotations() {
        let annotations = viewModel.annotations
        
        XCTAssertEqual(annotations.count, 4)
    }
    
    func testCalculateRoutePolyline() {
        let polylines = viewModel.routePolylines
        
        XCTAssertEqual(polylines.count, 2)
    }
}




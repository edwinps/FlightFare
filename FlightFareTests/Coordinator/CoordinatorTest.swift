//
//  File.swift
//  FlightFareTests
//
//  Created by Edwin Peña Sanchez
//

import XCTest
@testable import FlightFare

class CoordinatorViewTests: XCTestCase {
    var coordinator: Coordinator!
    var routeViewModel: RouteViewModel!
    var mapViewModel: MapViewModel!
    
    override func setUp() {
        super.setUp()
        coordinator = Coordinator()
        routeViewModel = RouteViewModel()
        mapViewModel = MapViewModel(selectedRoute: [])
        coordinator.mapViewModel = mapViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        coordinator = nil
        routeViewModel = nil
        mapViewModel = nil
    }
    
    func testCoordinatorWithRouteView() {
        let routeView = coordinator.buildHome(with: routeViewModel)
        
        XCTAssertNotNil(routeView)
    }
    
    func testCoordinatorthSheetView() {
        let sheetView = coordinator.buildMap(with: mapViewModel)
        
        XCTAssertNotNil(sheetView)
    }
    
    func testCoordinatorDismiss() {
        coordinator.sheet = .mapview
        coordinator.dismiss()
        
        XCTAssertNil(coordinator.sheet)
    }
    
    func testCoordinatorPresent() {
        coordinator.sheet = nil
        coordinator.presentMap(viewModel: mapViewModel)
        
        XCTAssertNotNil(coordinator.sheet)
    }
}

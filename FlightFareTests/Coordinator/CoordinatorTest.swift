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
    }
    
    override func tearDown() {
        super.tearDown()
        coordinator = nil
        routeViewModel = nil
        mapViewModel = nil
    }
    
    func testCoordinatorWithRouteView() {
        let routeView = coordinator.buildPageView(for: .home)
        
        XCTAssertNotNil(routeView)
    }
    
    func testCoordinatorthSheetView() {
        let sheetView = coordinator.buildSheetView(for: .mapview(viewModel: mapViewModel))
        
        XCTAssertNotNil(sheetView)
    }
    
    func testCoordinatorDismiss() {
        coordinator.sheet = .mapview(viewModel: mapViewModel)
        coordinator.dismiss()
        
        XCTAssertNil(coordinator.sheet)
    }
    
    func testCoordinatorPresent() {
        coordinator.sheet = nil
        coordinator.present(sheet: .mapview(viewModel: mapViewModel))
        
        XCTAssertNotNil(coordinator.sheet)
    }
    
    func testSheetHashAndEquality() {
        let viewModel1 = MapViewModel(selectedRoute: [])
        let viewModel2 = MapViewModel(selectedRoute: [MockModels.connection])
        
        let sheet1 = Sheet.mapview(viewModel: viewModel1)
        let sheet2 = Sheet.mapview(viewModel: viewModel1)
        let sheet3 = Sheet.mapview(viewModel: viewModel2)
        
        XCTAssertEqual(sheet1, sheet2)
        XCTAssertEqual(sheet1.hashValue, sheet2.hashValue)
        XCTAssertNotEqual(sheet1, sheet3)
    }
    
    func testPageHashAndEquality() {
        let page1 = Page.home
        let page2 = Page.home
        
        XCTAssertEqual(page1, page2)
        XCTAssertEqual(page1.id, page2.id)
    }
}

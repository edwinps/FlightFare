//
//  RouteFinderTests.swift
//  FlightFareTests
//
//  Created by Edwin Peña Sanchez .
//

import XCTest
@testable import FlightFare

final class RouteFinderTests: XCTestCase {
    let connections = MockModels.connections
    
    func testFindCheapestRoute_Success() {
        let routeFinder = RouteFinder(connections: connections)
        
        let bestRoute = routeFinder.findCheapestRoute(from: "CityA", to: "CityC")
        
        XCTAssertNotNil(bestRoute)
        XCTAssertEqual(bestRoute?.count, 2)
    }
    
    func testFindCheapestRoute_NoRoute() {
        let routeFinder = RouteFinder(connections: connections)
        
        let bestRoute = routeFinder.findCheapestRoute(from: "CityA", to: "CityE")
        
        XCTAssertNil(bestRoute)
    }
}

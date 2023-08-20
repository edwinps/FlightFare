//
//  MockRouteViewModel.swift
//  FlightFareTests
//
//  Created by Edwin Peña Sanchez .
//

import XCTest
@testable import FlightFare

class MockRouteViewModel: RouteViewModel {
    var calculateSelectedRouteCalled = false
    
    override func calculateSelectedRoute() {
        calculateSelectedRouteCalled = true
    }
}

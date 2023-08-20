//
//  RouteViewModelTests.swift
//  FlightFareTests
//
//  Created by Edwin Peña Sanchez .
//

import XCTest
@testable import FlightFare

final class RouteViewModelTests: XCTestCase {
    var mockFetchConnectionsUseCase: MockFetchConnectionsUseCase!
    var viewModel: RouteViewModel!
    var connections: [Connection]!
    
    override func setUp() {
        super.setUp()
        connections = MockModels.connections
        mockFetchConnectionsUseCase = MockFetchConnectionsUseCase()
        viewModel = RouteViewModel(fetchConnectionsUseCase: mockFetchConnectionsUseCase)
    }
    
    override func tearDown() {
        super.tearDown()
        connections = []
        mockFetchConnectionsUseCase = nil
        viewModel = nil
    }
    
    func testFetchConnectionsAndAvailableCities_Success() async throws {
        let expectation = XCTestExpectation(description: "Fetch connections and available cities")
        mockFetchConnectionsUseCase.mockedFetchConnectionsResult = .success(connections)
        
        await viewModel.fetchConnectionsAndAvailableCities()
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel.availableCities, ["CityA", "CityB", "CityC"])
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 3.0)
    }
    
    func testFetchConnectionsAndAvailableCities_Failure() async throws {
        mockFetchConnectionsUseCase.mockedFetchConnectionsResult = .failure(MockError())
        let expectation = XCTestExpectation(description: "Fetch connections and available cities")
        
        await viewModel.fetchConnectionsAndAvailableCities()
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.viewModel.showAlert)
            XCTAssertEqual(self.viewModel.alertMessage,
                           "Error calculating route The operation couldn’t be completed. (FlightFareTests.MockError error 1.)")
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 3.0)
    }
    
    
    func testCalculateSelectedRoute_Success() async {
        mockFetchConnectionsUseCase.mockedFetchConnectionsResult = .success(connections)
        viewModel.departureCity = "CityA"
        viewModel.destinationCity = "CityB"
        let expectation = XCTestExpectation(description: "Calculate selected route")
        
        await viewModel.fetchConnectionsAndAvailableCities()
        viewModel.calculateSelectedRoute()
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel.selectedRoute.count, 1)
            XCTAssertEqual(self.viewModel.totalPrice, 100)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 3.0)
    }
}

//
//  FetchConnectionsUseCaseTests.swift
//  FlightFareTests
//
//  Created by Edwin Peña Sanchez 
//

import XCTest
@testable import FlightFare

final class FetchConnectionsUseCaseTests: XCTestCase {
    func testFetchConnections_Success() async throws {
        let mockUrlSession = MockURLSession()
        let useCase = FetchConnectionsUseCase(urlSession: mockUrlSession)
        
        guard let testDataURL = Bundle(for: type(of: self)).url(forResource: "connections", withExtension: "json"),
              let response = HTTPURLResponse(url: testDataURL,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: nil) else {
            XCTFail("Test data file not found")
            return
        }
        
        let testData = try Data(contentsOf: testDataURL)
        mockUrlSession.mockDataTaskResult = .success((testData, response))
        let result = await useCase.fetchConnections()
        switch result {
        case .success(let connections):
            XCTAssertEqual(connections.count, 9)
        case .failure:
            XCTFail("Unexpected failure")
        }
    }
    
    func testFetchConnections_Failure() async throws {
        let mockUrlSession = MockURLSession()
        let useCase = FetchConnectionsUseCase(urlSession: mockUrlSession)
        mockUrlSession.mockDataTaskResult = .failure(NSError(domain: "test", code: 123, userInfo: nil))
        
        let result = await useCase.fetchConnections()
        switch result {
        case .success:
            XCTFail("Unexpected success")
        case .failure(let error):
            XCTAssertEqual((error as NSError).code, 123)
        }
    }
}

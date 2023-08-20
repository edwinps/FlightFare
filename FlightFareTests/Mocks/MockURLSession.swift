//
//  MockURLSession.swift
//  FlightFareTests
//
//  Created by Edwin Peña Sanchez 
//

import XCTest
@testable import FlightFare

final class MockURLSession: URLSessionProtocol {
    var mockDataTaskResult: AsyncResult<(Data, URLResponse), Error>?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let result = mockDataTaskResult {
            switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
            }
        }
        fatalError("Mock result not set")
    }
}

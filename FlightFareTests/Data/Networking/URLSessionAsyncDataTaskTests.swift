//
//  URLSessionAsyncDataTaskTests.swift
//  FlightFareTests
//
//  Created by Edwin Peña Sanchez 
//

import XCTest
@testable import FlightFare

final class URLSessionAsyncDataTaskTests: XCTestCase {
    
    func testAsyncDataTask_Success() async throws {
        let mockUrlSession = MockURLSession()
        guard let testDataURL = URL(string: "https://example.com"),
              let response = HTTPURLResponse(url: testDataURL,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: nil) else {
            XCTFail("Unexpected failure")
            return
        }
        let data = Data("Test data".utf8)
        mockUrlSession.mockDataTaskResult = .success((data, response))
        let result = await mockUrlSession.asyncDataTask(with: testDataURL)
        
        switch result {
        case .success(let fetchedData):
            XCTAssertEqual(fetchedData, data)
        case .failure:
            XCTFail("Unexpected failure")
        }
    }
    
    func testAsyncDataTask_Failure() async throws {
        let mockUrlSession = MockURLSession()
        let url = URL(string: "https://example.com")!
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: nil)
        mockUrlSession.mockDataTaskResult = .failure(error)
        
        let result = await mockUrlSession.asyncDataTask(with: url)
        
        switch result {
        case .success:
            XCTFail("Unexpected success")
        case .failure(let fetchedError):
            XCTAssertEqual(fetchedError as NSError, error)
        }
    }
    
    func testAsyncDataTask_BadStatusCode() async throws {
        let mockUrlSession = MockURLSession()
        let url = URL(string: "https://example.com")!
        guard let testDataURL = URL(string: "https://example.com"),
              let response = HTTPURLResponse(url: testDataURL,
                                             statusCode: 404,
                                             httpVersion: nil,
                                             headerFields: nil) else {
            XCTFail("Unexpected failure")
            return
        }
        mockUrlSession.mockDataTaskResult = .success((Data(), response))
        let result = await mockUrlSession.asyncDataTask(with: url)
        
        switch result {
        case .success:
            XCTFail("Unexpected success")
        case .failure(let fetchedError):
            XCTAssertEqual((fetchedError as NSError).code, NSURLErrorBadServerResponse)
        }
    }
}


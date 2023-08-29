//
//  EnvironmentTests.swift
//  FlightFareTests
//
//  Created by Edwin Peña Sanchez on 29/8/23.
//

import XCTest
@testable import FlightFare

final class EnvironmentTests: XCTestCase {
    
    func testApiUrl() {
        let apiUrl = try? Environment.apiUrl()
        
        XCTAssertEqual(apiUrl?.absoluteString, "http://localhost:8000")
    }
    
    func testApiUrlNotSetInPlist() {
        let testBundle = Bundle(for: type(of: self))
        
        XCTAssertThrowsError(try Environment.apiUrl(bundle: testBundle)) { error in
            XCTAssertEqual(error as? EnvironmentError, EnvironmentError.apiUrlNotSet)
        }
    }
    
    func testApiUrlPlistFileNotFound() {
        let testBundle = BundleMock(infoDictionary: nil)
        
        XCTAssertThrowsError(try Environment.apiUrl(bundle: testBundle)) { error in
            XCTAssertEqual(error as? EnvironmentError, EnvironmentError.plistFileNotFound)
        }
    }
}

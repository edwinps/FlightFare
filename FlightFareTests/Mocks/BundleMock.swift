//
//  BundleMock.swift
//  FlightFareTests
//
//  Created by Edwin Peña Sanchez on 29/8/23.
//

import XCTest
@testable import FlightFare

class BundleMock: Bundle {
    private let mockInfoDictionary: [String: Any]?
    
    init(infoDictionary: [String: Any]?) {
        self.mockInfoDictionary = infoDictionary
        super.init()
    }
    
    override var infoDictionary: [String: Any]? {
        return mockInfoDictionary
    }
}

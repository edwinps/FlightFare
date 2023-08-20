//
//  MockFetchConnectionsUseCase.swift
//  FlightFareTests
//
//  Created by Edwin Peña Sanchez .
//

import XCTest
@testable import FlightFare

class MockFetchConnectionsUseCase: FetchConnectionsUseCaseProtocol {
    var mockedFetchConnectionsResult: AsyncResult<[Connection], Error> = .success([])
    
    func fetchConnections() async -> AsyncResult<[Connection], Error> {
        return mockedFetchConnectionsResult
    }
}

struct MockError: Error { }

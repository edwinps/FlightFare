//
//  MockModels.swift
//  FlightFareTests
//
//  Created by Edwin Peña Sanchez on 20/8/23.
//

import XCTest
@testable import FlightFare

struct MockModels {
    static let connections = [
        Connection(
            from: City(name: "CityA", coordinates: Coordinates(lat: 1, long: -1)),
            to: City(name: "CityB", coordinates: Coordinates(lat: 2, long: -2)),
            price: 100
        ),
        Connection(
            from: City(name: "CityB", coordinates: Coordinates(lat: 1, long: -1)),
            to: City(name: "CityC", coordinates: Coordinates(lat: 2, long: -2)),
            price: 150
        )
    ]
    
    static let connection = Connection(
        from: City(name: "City A", coordinates: Coordinates(lat: 40.0, long: -75.0)),
        to: City(name: "City B", coordinates: Coordinates(lat: 41.0, long: -74.0)),
        price: 100)
}

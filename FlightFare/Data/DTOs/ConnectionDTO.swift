//
//  City.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez 
//

import Foundation

struct ConnectionsListDTO: Codable {
    let connections: [ConnectionDTO]
}

struct ConnectionDTO: Codable {
    let from: String
    let to: String
    let price: Int
    let coordinates: ConnectionCoordinatesDTO
}

struct ConnectionCoordinatesDTO: Codable {
    let from: CoordinatesDTO
    let to: CoordinatesDTO
}

struct CoordinatesDTO: Codable {
    let lat: Double
    let long: Double
}

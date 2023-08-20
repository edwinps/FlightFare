//
//  City.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez 
//

import Foundation
import CoreLocation

struct City: Hashable {
    let name: String
    let coordinates: Coordinates
}

struct Coordinates: Hashable {
    let lat: Double
    let long: Double
    
    func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}

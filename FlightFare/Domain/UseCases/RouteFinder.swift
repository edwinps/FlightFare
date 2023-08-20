//
//  RouteFinder.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez .
//

import Foundation

struct RouteFinder {
    private let connections: [Connection]
    
    init(connections: [Connection]) {
        self.connections = connections
    }
    
    func findCheapestRoute(from departure: String,
                           to destination: String) -> [Connection]? {
        var visitedCities = Set<String>()
        var routes = [[Connection]]()
        
        findRoutes(from: departure,
                   to: destination,
                   visitedCities: &visitedCities,
                   currentRoute: [],
                   routes: &routes)
        
        if let bestRoute = routes.min(by: { totalPrice(for: $0) < totalPrice(for: $1) }) {
            return bestRoute
        }
        return nil
    }
}

private extension RouteFinder {
    func findRoutes(from currentCity: String,
                    to destination: String,
                    visitedCities: inout Set<String>,
                    currentRoute: [Connection],
                    routes: inout [[Connection]]) {
        visitedCities.insert(currentCity)
        
        if currentCity == destination {
            routes.append(currentRoute)
        }
        
        for connection in connections {
            if connection.from.name == currentCity && !visitedCities.contains(connection.to.name) {
                findRoutes(from: connection.to.name,
                           to: destination,
                           visitedCities: &visitedCities,
                           currentRoute: currentRoute + [connection],
                           routes: &routes)
            }
        }
        
        visitedCities.remove(currentCity)
    }
    
    func totalPrice(for route: [Connection]) -> Int {
        return route.reduce(0) { $0 + $1.price }
    }
}

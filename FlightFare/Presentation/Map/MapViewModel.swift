//
//  MapViewModel.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez 
//

import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    var id: String {
        return "\(centerCoordinate.latitude)-\(centerCoordinate.longitude)-\(annotations.count)-\(routePolylines.count)"
    }
    @Published var centerCoordinate: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0)
    @Published var annotations = [MKPointAnnotation]()
    @Published var routePolylines = [MKPolyline]()
    
    init(selectedRoute: [Connection]) {
        self.centerCoordinate = self.calculateCenterCoordinate(with: selectedRoute)
        self.annotations = self.createMapAnnotations(with: selectedRoute)
        self.routePolylines = self.calculateRoutePolyline(with: selectedRoute)
    }
}

private extension MapViewModel {
    func calculateCenterCoordinate(with routes: [Connection]) -> CLLocationCoordinate2D {
        guard let departureCityCoordinates = routes.first?.from.coordinates else {
            return .init(latitude: 0, longitude: 0)
        }
        return departureCityCoordinates.toCLLocationCoordinate2D()
    }
    
    func createMapAnnotations(with routes: [Connection]) ->  [MKPointAnnotation] {
        return routes.flatMap { connection in
            createAnnotations(for: connection)
        }
    }
    
    func createAnnotations(for connection: Connection) -> [MKPointAnnotation] {
        let fromAnnotation = createAnnotation(latitude: connection.from.coordinates.lat,
                                              longitude: connection.from.coordinates.long)
        let toAnnotation = createAnnotation(latitude: connection.to.coordinates.lat,
                                            longitude: connection.to.coordinates.long)
        return [fromAnnotation, toAnnotation]
    }
    
    func createAnnotation(latitude: CLLocationDegrees,
                          longitude: CLLocationDegrees) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude,
                                                       longitude: longitude)
        return annotation
    }
    
    func calculateRoutePolyline(with routes: [Connection]) -> [MKPolyline] {
        var allPolylines: [MKPolyline] = []
        for route in calculateAllRoutes(with: routes) {
            let polyline = MKPolyline(coordinates: route, count: route.count)
            allPolylines.append(polyline)
        }
        
        return allPolylines
    }
    
    func calculateAllRoutes(with routes: [Connection]) -> [[CLLocationCoordinate2D]] {
        guard routes.count > 0 else {
            return []
        }
        var allRoutes: [[CLLocationCoordinate2D]] = []
        for connection in routes {
            let startCoordinate = connection.from.coordinates.toCLLocationCoordinate2D()
            let endCoordinate = connection.to.coordinates.toCLLocationCoordinate2D()
            let routeCoordinates = calculateIntermediateCoordinates(startCoordinate: startCoordinate,
                                                                    endCoordinate: endCoordinate)
            allRoutes.append([startCoordinate] + routeCoordinates + [endCoordinate])
        }
        
        return allRoutes
    }
    
    func calculateIntermediateCoordinates(startCoordinate: CLLocationCoordinate2D,
                                          endCoordinate: CLLocationCoordinate2D) -> [CLLocationCoordinate2D] {
        let numIntermediatePoints = 5
        var intermediateCoordinates: [CLLocationCoordinate2D] = []
        
        for i in 1..<numIntermediatePoints {
            let intermediateLatitude = startCoordinate.latitude + (endCoordinate.latitude - startCoordinate.latitude) * CLLocationDegrees(i) / CLLocationDegrees(numIntermediatePoints)
            let intermediateLongitude = startCoordinate.longitude + (endCoordinate.longitude - startCoordinate.longitude) * CLLocationDegrees(i) / CLLocationDegrees(numIntermediatePoints)
            let intermediateCoordinate = CLLocationCoordinate2D(latitude: intermediateLatitude, longitude: intermediateLongitude)
            intermediateCoordinates.append(intermediateCoordinate)
        }
        return intermediateCoordinates
    }
}


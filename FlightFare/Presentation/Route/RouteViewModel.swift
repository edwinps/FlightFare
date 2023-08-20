//
//  RouteViewModel.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez .
//

import Foundation
import CoreLocation
import MapKit

class RouteViewModel: ObservableObject {
    @Published var departureCity: String = ""
    @Published var destinationCity: String = ""
    @Published var selectedRoute: [Connection] = []
    @Published var availableCities: [String]?
    @Published var totalPrice: Int = 0
    @Published var showAlert = false
    @Published var alertMessage = ""
    private let fetchConnectionsUseCase: FetchConnectionsUseCaseProtocol
    private var connections: [Connection] = [] {
        didSet {
            updateAvailableCities()
        }
    }
    
    init(fetchConnectionsUseCase: FetchConnectionsUseCaseProtocol = FetchConnectionsUseCase()) {
        self.fetchConnectionsUseCase = fetchConnectionsUseCase
    }
    
    func fetchConnectionsAndAvailableCities() async {
        do {
            connections = try await fetchConnectionsUseCase.fetchConnections().getData()
        } catch {
            showAlert(message: "Error calculating route \(error.localizedDescription)")
        }
    }
    
    func calculateSelectedRoute() {
        guard let route = selectedRouteFinder.findCheapestRoute(from: departureCity,
                                                                to: destinationCity),
              route.count > 0 else {
            showAlert(message: "There are no routes for the selected cities")
            return
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.updateSelectedRoute(route)
            self.updateTotalPrice(for: route)
        }
    }
}

private extension RouteViewModel {
    var selectedRouteFinder: RouteFinder {
        return RouteFinder(connections: connections)
    }
    
    func updateAvailableCities() {
        let citiesSet = Set(connections.flatMap { [$0.from.name, $0.to.name] })
        DispatchQueue.main.async {[weak self] in
            self?.availableCities = citiesSet.sorted()
        }
    }
    
    func updateSelectedRoute(_ route: [Connection]) {
        self.selectedRoute = route
    }
    
    func updateTotalPrice(for route: [Connection]) {
        self.totalPrice = route.map(\.price).reduce(0, +)
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.alertMessage = message
            self?.showAlert = true
        }
    }
}

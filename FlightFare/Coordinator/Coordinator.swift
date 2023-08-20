//
//  Coordinator.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez 
//

import SwiftUI
import Foundation

enum Sheet: String, Identifiable {
    case mapview
    
    var id: String {
        self.rawValue
    }
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var mapViewModel: MapViewModel?
    
    func presentMap(viewModel: MapViewModel) {
        self.sheet = .mapview
        self.mapViewModel = viewModel
    }

    func dismiss() {
        self.sheet = nil
    }
    
    
    @ViewBuilder
    func buildHome(with viewModel: RouteViewModel) -> some View {
        RouteView(viewModel: viewModel)
    }
    
    @ViewBuilder
    func buildMap(with viewModel: MapViewModel) -> some View {
        MapView(viewModel: viewModel, coordinator: self)
    }
}

//
//  Coordinator.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez 
//

import SwiftUI
import Foundation

enum Page: Identifiable, Hashable {
    case home
    var id: Self { self }
}

enum Sheet: Identifiable, Hashable {
    case mapview(viewModel: MapViewModel)
    
    static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: String {
        switch self {
        case .mapview(let viewModel):
            return viewModel.id
        }
    }
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    private var routeViewModel = RouteViewModel()
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }

    func dismiss() {
        self.sheet = nil
    }
    
    @ViewBuilder
    func buildPageView(for page: Page) -> some View {
        switch page {
        case .home:
            RouteView(viewModel: routeViewModel)
        }
    }
    
    @ViewBuilder
    func buildSheetView(for sheet: Sheet) -> some View {
        switch sheet {
        case .mapview(let viewModel):
            MapView(viewModel: viewModel, coordinator: self)
        }
    }
}

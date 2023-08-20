//
//  CoordinatorView.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez 
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coodinator = Coordinator()
    @StateObject private var routeViewModel = RouteViewModel()
    
    var body: some View {
        NavigationStack(path: $coodinator.path) {
            buildRouteView()
                .sheet(item: $coodinator.sheet) { sheet in
                    buildSheetView(for: sheet)
                }
        }
        .environmentObject(coodinator)
    }
}

private extension CoordinatorView {
    @ViewBuilder
    func buildRouteView() -> some View {
        coodinator.buildHome(with: routeViewModel)
    }
    
    @ViewBuilder
    func buildSheetView(for sheet: Sheet) -> some View {
        if let viewModel = coodinator.mapViewModel {
            coodinator.buildMap(with: viewModel)
        }
    }
}

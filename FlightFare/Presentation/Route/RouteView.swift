//
//  RouteView.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez
//

import SwiftUI
import MapKit

struct RouteView: View {
    @ObservedObject var viewModel: RouteViewModel
    @State private var isShowingMap = false
    @EnvironmentObject private var coordinator: Coordinator
    
    var isShowRouteEnabled: Bool {
        !viewModel.selectedRoute.isEmpty
    }
    
    var body: some View {
        VStack {
            inputFieldsSection
            calculateRouteButton
            showRouteButton
            selectedRouteSection
        }
        .onAppear {
            Task {
                await viewModel.fetchConnectionsAndAvailableCities()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.alertMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

private extension RouteView {
    var inputFieldsSection: some View {
        Group {
            let availableCities = viewModel.availableCities ?? []
                AutocompleteTextFieldView(selectedCity: $viewModel.departureCity,
                                          availableCities: availableCities,
                                          textFieldText: "Departure City")
                AutocompleteTextFieldView(selectedCity: $viewModel.destinationCity,
                                          availableCities: availableCities,
                                          textFieldText: "Destination City")
            }
        }
    
    var calculateRouteButton: some View {
        Button("Calculate Route") {
            viewModel.calculateSelectedRoute()
        }.padding()
    }
    
    var showRouteButton: some View {
        Button("Show Route on Map") {
            coordinator.presentMap(viewModel: MapViewModel(selectedRoute: viewModel.selectedRoute))
        }
        .disabled(!isShowRouteEnabled)
    }
    
    var selectedRouteSection: some View {
        Group {
            if !viewModel.selectedRoute.isEmpty {
                Text("Selected Route:")
                    .font(.headline)
                    .padding()
                ForEach(viewModel.selectedRoute, id: \.self) { connection in
                    Text("\(connection.from.name) to \(connection.to.name) - \(connection.price)")
                        .padding(.horizontal)
                }
                Text("Total Price: \(viewModel.totalPrice)")
                    .font(.headline)
                    .padding()
            }
        }
    }
}

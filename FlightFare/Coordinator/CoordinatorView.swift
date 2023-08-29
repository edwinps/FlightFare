//
//  CoordinatorView.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez 
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coodinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coodinator.path) {
            coodinator.buildPageView(for: .home)
                .navigationDestination(for: Page.self) { page in
                    coodinator.buildPageView(for: page)
                }
                .sheet(item: $coodinator.sheet) { sheet in
                    coodinator.buildSheetView(for: sheet)
                }
        }
        .environmentObject(coodinator)
    }
}


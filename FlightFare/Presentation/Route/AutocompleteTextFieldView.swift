//
//  AutocompleteTextFieldView.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez .
//

import SwiftUI

struct AutocompleteTextFieldView: View {
    @State private var searchText = ""
    @State private var isEditing = false
    @Binding var selectedCity: String
    var availableCities: [String]
    var textFieldText: String
    
    var filteredCities: [String] {
        searchText.isEmpty ? [] : availableCities.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        VStack {
            TextField(textFieldText,
                      text: Binding(
                        get: { searchText },
                        set: { newValue in
                            searchText = newValue
                            selectedCity = newValue
                        }
                      ),
                      onEditingChanged: { editing in
                isEditing = editing
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            
            if isEditing {
                List(filteredCities, id: \.self) { city in
                    Button(action: {
                        selectedCity = city
                        searchText = city
                        isEditing = false
                    }) {
                        Text(city)
                    }
                }
                .background(Color.white)
            }
        }
    }
}

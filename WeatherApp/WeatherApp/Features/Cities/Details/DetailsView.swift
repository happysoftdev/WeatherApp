//
//  DetailsView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI

struct DetailsView: View {
    
    @StateObject var viewModel = ForecastViewModel()
    @AppStorage("temperatureUnit") private var selectedUnit: TemperatureUnit = .celsius
    
    var lat: Double? = nil
    var lon: Double? = nil
    var locationName: String? = nil
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                Text(viewModel.forecast?.name ?? "default title")
                    .font(.headline)
                Text(String(viewModel.forecast?.mainTemperature.temp ?? 0))
                    .font(.headline)
            }
            
            Text("Temperature unit; \(selectedUnit.rawValue)")
        }
        .navigationTitle("City details")
        .onAppear {
            if let locationName = locationName {
                viewModel.fetch(lat: nil, lon: nil, locationName: locationName, unit: selectedUnit.rawValue)
            } else if let lat = lat, let lon = lon {
                viewModel.fetch(lat: lat,lon: lon, unit: selectedUnit.rawValue)
            }
        }
        .onChange(of: selectedUnit) {
            print("Temperature unit did change") // new request here
            
            if let locationName = locationName {
                viewModel.fetch(lat: nil, lon: nil, locationName: locationName, unit: selectedUnit.rawValue)
            } else if let lat = lat, let lon = lon {
                viewModel.fetch(lat: lat,lon: lon, unit: selectedUnit.rawValue)
            }
        }
    }
}

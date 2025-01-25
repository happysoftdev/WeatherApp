//
//  DetailsView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI

struct DetailsView: View {
    
    @StateObject var viewModel = ForecastViewModel()
    
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
        }
        .navigationTitle("City details")
        .onAppear {
            if let locationName = locationName {
                viewModel.fetch(for: locationName)
            } else if let lat = lat, let lon = lon {
                viewModel.fetch(for: lat, and: lon)
            }
        }
    }
}

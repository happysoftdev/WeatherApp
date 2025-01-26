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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                if viewModel.isLoading {
                    CircularProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .font(.callout)
                } else {
                    WeatherInfoView(viewModel: viewModel)
                }
                Spacer()
                Text("Temperature unit; \(selectedUnit.rawValue)")
            }
            .navigationTitle("City details") //TODO: Add city title / current location text
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                //TODO: add a method in the VM that fetches data and call it here
                if let locationName = locationName {
                    viewModel.fetch(lat: nil, lon: nil, locationName: locationName, unit: selectedUnit.rawValue)
                } else if let lat = lat, let lon = lon {
                    viewModel.fetch(lat: lat,lon: lon, unit: selectedUnit.rawValue)
                }
            }
            .onChange(of: selectedUnit) {
                //TODO: add a method in the VM that fetches data and call it here
                if let locationName = locationName {
                    viewModel.fetch(lat: nil, lon: nil, locationName: locationName, unit: selectedUnit.rawValue)
                } else if let lat = lat, let lon = lon {
                    viewModel.fetch(lat: lat,lon: lon, unit: selectedUnit.rawValue)
                }
            }
        }
    }
}


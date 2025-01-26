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
    
    //TODO: Move these somewhere else
    var city: String? = nil
    var latitude: Double? = nil
    var longitude: Double? = nil
    
    init(viewModel: ForecastViewModel, city: String? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green.opacity(0.4)]),
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
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Current Weather")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .tint(.white)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                fetchData()
            }
            .onChange(of: selectedUnit) {
                fetchData()
            }
        }
    }
    
    private func fetchData() {
        if let city = city {
            viewModel.getWeather(city: city, unit: selectedUnit)
        } else if let lat = latitude, let lon = longitude {
            viewModel.getWeather(lat: lat, lon: lon, unit: selectedUnit)
        }
    }
}


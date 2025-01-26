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
//                if let locationName {
//                    viewModel.getWeather(for: locationName, unit: selectedUnit)
//                } else if let lat, let lon {
//                    viewModel.getWeather(with: lat, and: lon, unit: selectedUnit)
//                }
            }
            
            //TODO: Fix this
//            .onChange(of: selectedUnit) {
//                if let locationName {
//                    viewModel.getWeather(for: locationName, unit: selectedUnit)
//                } else if let lat, let lon {
//                    viewModel.getWeather(with: lat, and: lon, unit: selectedUnit)
//                }
//            }
        }
    }
}


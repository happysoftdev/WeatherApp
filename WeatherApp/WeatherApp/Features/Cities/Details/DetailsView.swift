//
//  DetailsView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI
struct WeatherInfoView: View {
    @ObservedObject var viewModel: ForecastViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.forecast?.name ?? "default title")
                .font(.system(size: 32, weight: .medium, design: .default))
                .foregroundStyle(.white)
                .padding(.bottom, 16)
            VStack(spacing: 10) {
                
                if let iconCode = viewModel.iconCode, let url = ApiEndpoints.iconURL(code: iconCode) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
                Text(String(viewModel.forecast?.mainTemperature.temp ?? 0))
                    .font(.system(size: 64, weight: .medium))
                    .foregroundStyle(.white)
            }
        }
    }
}

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
            VStack {
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
            .navigationTitle("City details")
            .navigationBarTitleDisplayMode(.inline)
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
}


//
//  ListView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var viewModel: ListViewModel
    @StateObject private var coordinator = HomeCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            VStack {
                List {
                    if let currentLocation = viewModel.currentLocation {
                        Section("Your location") {
                            NavigationLink(destination: coordinator.showDetails(for: currentLocation.name)) {
                                CityRowView(icon: viewModel.getWeatherIconName(for: currentLocation),
                                            name: currentLocation.name)
                                .padding(.vertical, 5)
                            }
                        }
                    }
                    Section("Other cities") {
                        ForEach(viewModel.defaultCities) { city in
                            NavigationLink(destination: coordinator.showDetails(for: city.name)) {
                                CityRowView(icon: viewModel.getWeatherIconName(for: city), name: city.name)
                                    .padding(.vertical, 5)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
            }
            .background(GradientBackgroundView().opacity(0.3))
            .navigationBarTitle("Weather", displayMode: .large)
        }
        .accentColor(.white)
    }
}

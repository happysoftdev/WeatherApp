//
//  ListView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI

struct ListView: View {
    @Environment(\.colorScheme) private var colorScheme
    
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
                .listStyle(.insetGrouped)
                .background(.clear)
            }
            .background(.clear)
            .navigationBarTitle("Weather", displayMode: .large)
        }
        .background(.clear)
        .accentColor(.white)
    }
}

struct CityRowView: View {
    let icon: String
    let name: String
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(.yellow)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
    }
}

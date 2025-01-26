//
//  ListView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI
import CoreLocation


struct SimpleLineView: View {
    var body: some View {
        VStack {
            // Line at the top of the screen
            Rectangle()
                .frame(height: 2) // Set the height of the line (thin)
                .foregroundColor(.blue) // Choose a color for the line
                .edgesIgnoringSafeArea(.horizontal) // Make it span across the full width of the screen
            
            Spacer() // Spacer to push content down
            
            // Content below the line
            Text("Below the line")
                .font(.title)
        }
    }
}


struct CustomBackgroundView: View {
    var body: some View {
        LinearGradient(gradient:
                        Gradient(colors: [Color.yellow, Color.green, Color.blue]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct ListView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject private var viewModel = ListViewModel()
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

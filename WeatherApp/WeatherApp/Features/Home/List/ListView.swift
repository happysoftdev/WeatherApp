//
//  ListView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI
import CoreLocation

struct ListView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject private var locationManager = LocationManager()
    @StateObject private var coordinator = HomeCoordinator()
    
    var defaultLocations: [String] = ["Tokyo", "London", "Barcelona"]
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            List {
//                if let locationName = locationManager.locationName, let location = locationManager.location {
//                    NavigationLink {
//                        DetailsView(lat: location.latitude, lon: location.longitude)
//                    } label: {
//                        Text("Your location: \(locationName)")
//                    }
//                }
                
                ForEach(defaultLocations, id: \.self) { location in
                    NavigationLink(
                        destination: coordinator.showDetails(for: location)
                    ) {
                        Text(location)
                    }
                }
            }
            .listStyle(.plain)
//            .onAppear {
//                locationManager.requestLocation()
//            }
            .background(colorScheme == .dark ? Color.black : Color.white)
            .navigationTitle("Weather")
            .padding()
        }
    }
}

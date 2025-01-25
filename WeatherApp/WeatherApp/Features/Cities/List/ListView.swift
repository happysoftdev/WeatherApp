//
//  ListView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI
import CoreLocation

struct ListView: View {
    
    @StateObject private var weatherViewModel = CityForecastViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var defaultLocations: [String] = ["Tokyo", "London", "Barcelona"]
    
    var body: some View {
        NavigationStack {
            List {
                if let locationName = locationManager.locationName {
                    NavigationLink {
                        DetailsView()
                    } label: {
                        Text("Your location: \(locationName)")
                    }
                }
                ForEach(defaultLocations, id: \.self) { location in
                    NavigationLink {
                        DetailsView()
                    } label: {
                        Text(location)
                    }
                }
            }
            .listStyle(.plain)
            .onAppear {
                locationManager.requestLocation()
            }
            .navigationTitle("Weather")
            .padding()
        }
    }
}

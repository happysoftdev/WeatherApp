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
    
    @StateObject private var viewModel = ListViewModel()
    @StateObject private var coordinator = HomeCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            VStack(alignment: .center) {
                if viewModel.isLoading {
                    CircularProgressView()
                } else {
                    
                    List(viewModel.cities, id: \.name) { city in
                        NavigationLink(
                            destination: coordinator.showDetails(for: city.name)
                        ) {
                            Text(city.name)
                        }
                    }
                    
                    .listStyle(.plain)
                    .onAppear {
                        print("fetch data about your current location")
                    }
                    .background(colorScheme == .dark ? Color.black : Color.white)
                    .navigationTitle("Your Cities")
                    .padding()
                    
                    Text(viewModel.errorMessage ?? "")
                        .padding()
                }
            }
        }
        .accentColor(.white)
    }
}

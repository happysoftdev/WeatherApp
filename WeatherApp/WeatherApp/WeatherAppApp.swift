//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            AppCoordinator()
                .ignoresSafeArea()
        }
    }
}


class HomeViewModel: ObservableObject {
    @Published var items: [String] = ["San Francisco", "New York", "Los Angeles", "Chicago"]
    
    func fetchItems() {
        // Simulate fetching data, e.g., from a network request
        items = ["San Francisco", "New York", "Los Angeles", "Chicago"]
    }
}




struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    let coordinator: HomeCoordinator
    
    var body: some View {
        NavigationView {
            List(viewModel.items, id: \.self) { item in
                NavigationLink(
                    destination: coordinator.goToDetails(for: item)
                ) {
                    Text(item)
                        .font(.headline)
                        .padding()
                }
            }
            .navigationTitle("Cities")
        }
        .onAppear {
            viewModel.fetchItems()
        }
    }
}



import SwiftUI

struct SettingsView2: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .padding()
        }
    }
}

import Foundation

class DetailsViewModel: ObservableObject {
    @Published var item: String
    @Published var details: String = ""
    
    init(item: String) {
        self.item = item
        fetchDetails()
    }
    
    func fetchDetails() {
        // Simulate fetching details for the item
        details = "Details about \(item)"
    }
}


import SwiftUI

struct DetailsView2: View {
    @ObservedObject var viewModel: DetailsViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.item)
                .font(.largeTitle)
                .padding()
            
            Text(viewModel.details)
                .font(.body)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Details")
    }
}

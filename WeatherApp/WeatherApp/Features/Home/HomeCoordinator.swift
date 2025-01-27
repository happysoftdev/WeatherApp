//
//  HomeCoordinator.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Foundation
import UIKit
import SwiftUI

// List & details screens
class HomeCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func start() -> UIViewController {
        let viewModel = ListViewModel()
        let homeView = ListView(viewModel: viewModel)
        
        let hostingController = UIHostingController(rootView: homeView)
        hostingController.view.backgroundColor = .clear
        
        hostingController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        return hostingController
    }
    
    func showDetails(for city: String) -> some View {
        let viewModel = ForecastViewModel(weatherService: WeatherService())
        return DetailsView(viewModel: viewModel, city: city)
    }
    
    func showDetails(for lat: Double, and lon: Double, locationName: String? = nil) -> some View {
        let viewModel = ForecastViewModel(weatherService: WeatherService())
        return DetailsView(viewModel: viewModel, city: locationName, latitude: lat, longitude: lon)
    }
}

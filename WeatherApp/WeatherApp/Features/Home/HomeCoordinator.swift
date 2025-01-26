//
//  HomeCoordinator.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Foundation
import UIKit
import SwiftUI

class HomeCoordinator {
    
    func start() -> UIViewController {
        let viewModel = HomeViewModel()
        let homeView = HomeView(viewModel: viewModel, coordinator: self)
        
        let hostingController = UIHostingController(rootView: homeView)
        
        hostingController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        return hostingController
    }
    
    func goToDetails(for item: String) -> DetailsView2 {
        let detailsViewModel = DetailsViewModel(item: item)
        return DetailsView2(viewModel: detailsViewModel)
    }
}

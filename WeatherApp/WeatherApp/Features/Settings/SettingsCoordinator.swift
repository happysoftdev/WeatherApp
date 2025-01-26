//
//  SettingsCoordinator.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Foundation
import UIKit
import SwiftUI

class SettingsCoordinator {
    func start() -> UIViewController {
        
        let viewModel = SettingsViewModel()
        let settingsView = SettingsView2(viewModel: viewModel)
        
        let hostingController = UIHostingController(rootView: settingsView)

        hostingController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            selectedImage: UIImage(systemName: "gear.fill")
        )
        return hostingController
    }
}

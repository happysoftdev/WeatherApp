//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Foundation
import UIKit
import SwiftUI

struct AppCoordinator: UIViewControllerRepresentable {
    let tabBarCoordinator = TabBarCoordinator()
    
    func makeUIViewController(context: Context) -> UITabBarController {
        return tabBarCoordinator.start()
    }
    
    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
        // Handle updates if needed
    }
}

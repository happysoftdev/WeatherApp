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

struct AppCoordinator: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TabBarController {
        return TabBarController()
    }
    
    func updateUIViewController(_ uiViewController: TabBarController, context: Context) {}
}

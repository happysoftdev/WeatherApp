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

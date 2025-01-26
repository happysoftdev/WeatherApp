//
//  TabBarCoordinator.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Foundation
import UIKit

class TabBarCoordinator {
    var tabBarController: UITabBarController

    init() {
        self.tabBarController = UITabBarController()
    }

    func start() -> UITabBarController {
        let homeView = HomeCoordinator().start()
        let settingsView = SettingsCoordinator().start()

        tabBarController.viewControllers = [homeView, settingsView]
        tabBarController.selectedIndex = 0

        return tabBarController
    }
}

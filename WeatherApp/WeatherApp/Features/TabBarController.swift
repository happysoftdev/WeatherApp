//
//  TabBarController.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation
import UIKit
import SwiftUI

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        let listTab = UIHostingController(rootView: ListView())
        listTab.tabBarItem = UITabBarItem(title: "Cities", image: UIImage(systemName: "house"), tag: 0)
        
        let settingsTab = UIHostingController(rootView: SettingsView())
        settingsTab.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        
        self.viewControllers = [listTab, settingsTab]
    }
}

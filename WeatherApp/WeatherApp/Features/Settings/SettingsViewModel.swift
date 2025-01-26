//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Combine
import SwiftUI

// rawValue, .allCases, ForEach
enum TemperatureUnit: String, CaseIterable, Identifiable {
    case fahrenheit = "Fahrenheit"
    case celsius = "Celsius"
    
    // Identifiable
    var id: String { self.rawValue }
}

class SettingsViewModel: ObservableObject {
    @AppStorage("temperatureUnit") var selectedUnit: TemperatureUnit = .celsius
}

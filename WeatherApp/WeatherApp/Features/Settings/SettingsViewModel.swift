//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Combine
import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("temperatureUnit") var selectedUnit: TemperatureUnit = .celsius
}

//
//  TemperatureUnitUtility.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Foundation


// rawValue, .allCases, ForEach
enum TemperatureUnit: String, CaseIterable, Identifiable {
    case fahrenheit = "Fahrenheit"
    case celsius = "Celsius"
    
    // Identifiable
    var id: String { self.rawValue }
}

class TemperatureUnitUtility {
    static func measureUnit(from unit: TemperatureUnit) -> String {
        switch unit {
        case .celsius:
            return "metric"
        case .fahrenheit:
            return "imperial"
        }
    }
}

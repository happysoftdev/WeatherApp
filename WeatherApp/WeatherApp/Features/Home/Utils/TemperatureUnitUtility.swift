//
//  TemperatureUnitUtility.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Foundation


// rawValue, .allCases, ForEach
enum TemperatureUnit: String, CaseIterable, Identifiable, Codable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    
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

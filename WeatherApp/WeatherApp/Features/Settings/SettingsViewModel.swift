//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Combine
import SwiftUI

class SettingsViewModel: ObservableObject {
    private var valueSubject = CurrentValueSubject<TemperatureUnit, Never>(.celsius) // Internal publisher

    // Exposed publisher with a transformation
    var valuePublisher: AnyPublisher<TemperatureUnit, Never> {
        valueSubject
            .map { $0 }
            .eraseToAnyPublisher()
    }

    // Update the value
    func updateValue(to newValue: TemperatureUnit) {
        valueSubject.send(newValue)
    }

}


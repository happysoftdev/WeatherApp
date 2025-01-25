//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI
import Combine

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

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Temperature Unit")) {
                    Picker("Unit", selection: $viewModel.selectedUnit) {
                        ForEach(TemperatureUnit.allCases) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Settings")
        }
    }
    
}

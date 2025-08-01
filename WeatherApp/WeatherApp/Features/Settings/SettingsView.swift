//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI
import Combine

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @AppStorage("unit") private var unit: TemperatureUnit = .celsius
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Preferences")
                    .font(.headline)
                    .foregroundColor(.blue)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "ruler.fill")
                                    .foregroundColor(.blue)
                                Text("Temperature unit")
                                    .font(.body)
                                    .accessibilityIdentifier("temperatureUnitText")
                            }
                            Picker("Unit", selection: $unit) {
                                ForEach(TemperatureUnit.allCases) { unit in
                                    Text(unit.rawValue).tag(unit)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .accessibilityIdentifier("temperatureUnitPicker")
                        }
                        .accessibilityIdentifier("temperatureUnitVStack")
                    }
            }
            .listStyle(GroupedListStyle())
            .scrollContentBackground(.hidden)
            .background(GradientBackgroundView().opacity(0.3))
            .navigationBarTitle("Settings", displayMode: .large)
            .onChange(of: unit) {
                CacheManager.shared.invalidateForecastArrayCache()
            }
        }
        .accentColor(.blue)
    }
}

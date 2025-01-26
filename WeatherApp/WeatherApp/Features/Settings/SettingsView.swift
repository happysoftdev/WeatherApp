//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI
import Combine

struct SettingsView: View {
    @State private var isDarkModeEnabled = false
    @State private var notificationsEnabled = true
    
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var viewModel = SettingsViewModel()
    
    @AppStorage("unit") private var unit: TemperatureUnit = .celsius
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Preferences")
                    .font(.headline)
                    .foregroundColor(.blue)) {
                        Toggle(isOn: $isDarkModeEnabled) {
                            HStack {
                                Image(systemName: "moon.fill")
                                    .foregroundColor(.blue)
                                Text("Dark Mode")
                                    .font(.body)
                            }
                        }
                        
                        Toggle(isOn: $notificationsEnabled) {
                            HStack {
                                Image(systemName: "bell.fill")
                                    .foregroundColor(.blue)
                                Text("Notifications")
                                    .font(.body)
                            }
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "ruler.fill")
                                    .foregroundColor(.blue)
                                Text("Temperature unit")
                                    .font(.body)
                            }
                            Picker("Unit", selection: $unit) {
                                ForEach(TemperatureUnit.allCases) { unit in
                                    Text(unit.rawValue).tag(unit)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Settings", displayMode: .large)
            .background(Color.white)
            .onChange(of: unit) {
                CacheManager.shared.invalidateForecastArrayCache()
            }
        }
        .accentColor(.blue)
    }
}

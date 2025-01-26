//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI
import Combine

//struct SettingsView: View {
//    @Environment(\.colorScheme) private var colorScheme
//    @StateObject var viewModel = SettingsViewModel()
//
//    var body: some View {
//        NavigationStack {
//            List {
//                Section(header: Text("Temperature Unit")) {
//                    Picker("Unit", selection: $viewModel.selectedUnit) {
//                        ForEach(TemperatureUnit.allCases) { unit in
//                            Text(unit.rawValue).tag(unit)
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                }
//            }
//            .listStyle(.plain)
//            .background(colorScheme == .dark ? Color.black : Color.white)
//            .navigationTitle("Settings")
//            .padding()
//        }
//    }
//}

import SwiftUI

struct SettingsView: View {
    @State private var isDarkModeEnabled = false
    @State private var notificationsEnabled = true
    
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                
                // Profile Section
                Section(header: Text("Profile")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.top, 20)) {
                        NavigationLink(destination: Text("Privacy Settings")) {
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.blue)
                                Text("Privacy Settings")
                                    .font(.body)
                            }
                        }
                    }
                
                // Preferences Section
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
                            Picker("Unit", selection: $viewModel.selectedUnit) {
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
        }
        .accentColor(.blue)
    }
}

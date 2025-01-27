//
//  CitiesListViewModel.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation
import Combine
import CoreLocation
import SwiftUI

class ListViewModel: ObservableObject {
    private var locationManager = LocationManager()
    
    @Published var currentLocation: City?
    @Published var defaultCities: [City] = [
        City(name: "London"),
        City(name: "Barcelona")
    ]
    
    @Published var errorMessage: String? = nil
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        locationManager.$errorMessage
            .sink { [weak self] errorMessage in
                self?.errorMessage = errorMessage
            }
            .store(in: &cancellables)
        
        let locationPublisher = locationManager.$currentLocation
        let locationNamePublisher = locationManager.$locationName
        
        locationPublisher
            .combineLatest(locationNamePublisher)
            .sink { [weak self] (location, name) in
                guard let location = location, let name = name else { return }
                self?.currentLocation = City(name: name)
                self?.errorMessage = nil
            }
            .store(in: &cancellables)
    }
    
    func getWeatherIconName(for city: City) -> String {
        switch city.name {
        case "Barcelona":
            return "cloud.fill"
        case "London":
            return  "cloud.sun.fill"
        default:
            return "sun.max.fill"
        }
    }
}

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
    
    @Published var cities: [City] = []
    @Published var cachedCities: [City] = []
    
    @Published var currentLocation: City?
    @Published var defaultCities: [City] = [
        City(name: "London"),
        City(name: "Barcelona")
    ]
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        loadCachedData()
        setupBindings()
    }
    
    func loadCachedData() {
        if let cachedData = CacheManager.shared.getCitiesArray() {
            self.cachedCities = cachedData
        }
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
                self?.fetchWeather(for: location, with: name)
            }
            .store(in: &cancellables)
    }
    
    func fetchWeather(for location: CLLocationCoordinate2D, with name: String) {
        let currentCity = City(name: name)
        currentLocation = currentCity
        errorMessage = nil
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

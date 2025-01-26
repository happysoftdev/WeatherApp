//
//  CitiesListViewModel.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation
import Combine
import CoreLocation

class ListViewModel: ObservableObject {
    private var locationManager = LocationManager()
    
    @Published var cities: [City] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        locationManager.$error
            .sink { [weak self] error in
                guard let error = error else { return }
                print("Error - location manager: \(error)")
                self?.errorMessage = error.localizedDescription
                self?.cities = self?.defaultCities() ?? []
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
        isLoading = true
        
        let currentCity = City(name: name, temperature: 23)
        cities = [currentCity] + defaultCities()
        errorMessage = nil
        isLoading = false
    }
    
    func defaultCities() -> [City] {
        return [
            City(name: "New York", temperature: 5),
            City(name: "London", temperature: 10),
            City(name: "Tokyo", temperature: 15)
        ]
    }
}

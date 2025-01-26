//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation
import Combine
import CoreLocation

class ForecastViewModel: ObservableObject {
    @Published var forecast: Forecast? = nil // TODO: should use forecast data instead of the whole object
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var iconCode: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let weatherService: WeatherServiceProtocol
    
    // DI
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func getWeather(city: String, unit: TemperatureUnit) {
        self.isLoading = true
        self.errorMessage = nil
        
        // checking cache for this certain city
        if let cachedData = CacheManager.shared.getCitiesArray(),
           let forecastCache = cachedData.first(where: { $0.name ==  city}) {
            self.forecast = forecastCache.forecast
            self.isLoading = false
        } else {
            // new request
            weatherService.fetchWeather(for: city, unit: getMeasureUnit(from: unit))
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .failure(let err):
                        self?.isLoading = false
                        print("Error is \(err.localizedDescription)")
                    case .finished:
                        print("Success")
                    }
                } receiveValue: { [weak self] response in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        self?.isLoading = false
                        self?.forecast = response
                        self?.iconCode = response.weather.first?.icon
                        
                        let city = City(forecast: response)
                        CacheManager.shared.addCityCache(city)
                    }
                } .store(in: &cancellables)
        }
    }
    
    func getWeather(lat: Double, lon: Double, unit: TemperatureUnit) {
        self.isLoading = true
        self.errorMessage = nil
        
        weatherService.fetchWeather(with: lat, and: lon, unit: getMeasureUnit(from: unit))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    self?.isLoading = false
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Success")
                }
            } receiveValue: { [weak self] response in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self?.isLoading = false
                    self?.forecast = response
                    self?.iconCode = response.weather.first?.icon
                }
            } .store(in: &cancellables)
    }
    
    func getMeasureUnit(from unit: TemperatureUnit) -> String {
        if unit == .celsius {
            return "metric"
        } else {
            return "imperial"
        }
    }
}

extension ForecastViewModel {
    static let mock = ForecastViewModel(weatherService: MockWeatherService())
}

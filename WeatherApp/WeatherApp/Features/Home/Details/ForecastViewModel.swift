//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation
import Combine
import CoreLocation
import SwiftUI

class ForecastViewModel: ObservableObject {
    @Published var forecast: Forecast? = nil // TODO: should use forecast data instead of the whole object
    
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var iconCode: String? = nil
    
    @Published var sunset: String = ""
    @Published var sunrise: String = ""
    @Published var lastUpdatedAt: String = ""
    
    @AppStorage("unit") private var unit: TemperatureUnit = .celsius
    
    private var cancellables = Set<AnyCancellable>()
    private let weatherService: WeatherServiceProtocol
    
    // DI
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func getWeather(city: String) {
        self.isLoading = true
        self.errorMessage = nil
        
        let unit = unit //CacheManager.shared.getUnit() ?? .celsius
        
        // checking cache for this certain city
        if let cachedData = CacheManager.shared.getCitiesArray(),
           let forecastCache = cachedData.first(where: { $0.name ==  city}) {
            
            checkIfHasNewData()
            
            self.forecast = forecastCache.forecast
            self.isLoading = false
            
            setLastUpdatedAt()
            setSunriseSunsetData()
        } else {
            // new request
            weatherService.fetchWeather(for: city, unit: TemperatureUnitUtility.measureUnit(from: unit))
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        self?.isLoading = false
                        self?.forecast = response
                        self?.iconCode = response.weather.first?.icon
                        
                        let city = City(forecast: response)
                        CacheManager.shared.addCityCache(city)
                        
                        self?.setLastUpdatedAt()
                        self?.setSunriseSunsetData()
                    }
                } .store(in: &cancellables)
        }
    }
    
    private func checkIfHasNewData() {
        // check if location is different
        // IMPROVEMENT: background refresh to get data and check if there is new data + invalidate after a period of time
    }
    
    func getWeather(lat: Double, lon: Double) {
        self.isLoading = true
        self.errorMessage = nil
        
        let unit = unit //CacheManager.shared.getUnit() ?? .celsius
        
        weatherService.fetchWeather(with: lat, and: lon, unit: TemperatureUnitUtility.measureUnit(from: unit))
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
    
    func setLastUpdatedAt() {
        guard let timeInterval = self.forecast?.date else { return }
        self.lastUpdatedAt = TimeUtility.convertUnixTimestampToLocal(timestamp: timeInterval)
    }
    
    func setSunriseSunsetData() {
        guard let sunriseTimeinterval = self.forecast?.systemData.sunrise else { return }
        guard let sunsetTimeinterval = self.forecast?.systemData.sunset else { return }
        
        self.sunrise = TimeUtility.convertUnixTimestampToUTC(timestamp: sunriseTimeinterval)
        self.sunset = TimeUtility.convertUnixTimestampToUTC(timestamp: sunsetTimeinterval)
    }
}

extension ForecastViewModel {
    static let mock = ForecastViewModel(weatherService: MockWeatherService())
}

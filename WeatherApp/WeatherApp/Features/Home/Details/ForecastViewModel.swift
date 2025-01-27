//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation
import Combine
import SwiftUI

class ForecastViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var iconCode: String? = nil
    
    @Published var locationName: String = ""
    @Published var temperature: String = ""
    @Published var feelsLike: String = ""
    @Published var minTemp: String = ""
    @Published var maxTemp: String = ""
    @Published var condition: String = ""
    @Published var conditionDescription: String = ""
    @Published var humidity: String = ""
    @Published var windSpeed: String = ""
    @Published var sunset: String = ""
    @Published var sunrise: String = ""
    @Published var lastUpdatedAt: String = ""
    
    @AppStorage("unit") private var unit: TemperatureUnit = .celsius
    
    private var cancellables = Set<AnyCancellable>()
    private let weatherService: WeatherServiceProtocol
    
    private var forecast: Forecast? {
        didSet {
            if let forecast {
                updateData(with: forecast)
            }
        }
    }
    
    private var temperatureFormat: String {
        return "%.0f°\(unitString())"
    }
    
    private var speedFormat: String {
        return "%.1f m/s"
    }
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func fetchData(lat: Double?, lon: Double?, city: String?) {
        self.isLoading = true
        self.errorMessage = nil
        self.locationName = city ?? ""
        
        // check cache
        if let cachedData = CacheManager.shared.getCitiesArray(),
           !locationName.isEmpty,
           let forecastDataCache = cachedData.first(where: { $0.name ==  locationName}),
           let forecast = forecastDataCache.forecast {
            self.isLoading = false
            self.forecast = forecast // load data from cache
        } else {
            if let city = city {
                getWeather(city: city)
            } else if let lat = lat, let lon = lon {
                getWeather(lat: lat, lon: lon)
            }
        }
    }
    
    func getWeather(city: String) {
        weatherService.fetchWeather(for: city, unit: TemperatureUnitUtility.measureUnit(from: unit))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    self?.isLoading = false
                    self?.errorMessage = "There was a problem with the request"
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Success")
                }
            } receiveValue: { [weak self] response in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self?.isLoading = false
                    self?.forecast = response
                }
            }
            .store(in: &cancellables)
        
    }
    
    func getWeather(lat: Double, lon: Double) {
        weatherService.fetchWeather(with: lat, and: lon, unit: TemperatureUnitUtility.measureUnit(from: unit))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    self?.isLoading = false
                    self?.errorMessage = "There was a problem with the request"
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Success")
                }
            } receiveValue: { [weak self] response in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self?.isLoading = false
                    self?.forecast = response
                }
            }
            .store(in: &cancellables)
    }
    
    private func checkIfHasNewData() {
        // check if location is different
        // IMPROVEMENT: background refresh to get data and check if there is new data + invalidate after a period of time
    }
    
    func setLastUpdatedAt(for forecast: Forecast) {
        let timeInterval = forecast.date
        self.lastUpdatedAt = TimeUtility.convertUnixTimestampToLocal(timestamp: timeInterval)
    }
    
    func setSunriseSunsetData(for forecast: Forecast) {
        let sunriseTimeinterval = forecast.systemData.sunrise
        let sunsetTimeinterval = forecast.systemData.sunset
        
        self.sunrise = TimeUtility.convertUnixTimestampToUTC(timestamp: sunriseTimeinterval)
        self.sunset = TimeUtility.convertUnixTimestampToUTC(timestamp: sunsetTimeinterval)
    }
    
    func updateData(with forecast: Forecast) {
        iconCode = forecast.weather.first?.icon
        
        locationName = forecast.name
        temperature = String(format: temperatureFormat, forecast.mainTemperature.temp)
        
        feelsLike = "Feels like \(String(format: temperatureFormat, forecast.mainTemperature.feelsLike))"
        minTemp = String(format: temperatureFormat, forecast.mainTemperature.tempMin)
        maxTemp = String(format: temperatureFormat, forecast.mainTemperature.tempMax)
        
        condition = forecast.weather.first?.main ?? ""
        conditionDescription = forecast.weather.first?.description ?? ""
        
        humidity = "\(String(describing: forecast.mainTemperature.humidity))%"
        windSpeed =  String(format: speedFormat, forecast.wind.speed)
        
        setLastUpdatedAt(for: forecast)
        setSunriseSunsetData(for: forecast)
        
        // save data to cache
        let city = City(forecast: forecast)
        CacheManager.shared.addCityCache(city)
    }
    
    func unitString() -> String { return unit == .celsius ? "C" : "F" }
}

extension ForecastViewModel {
    static let mock = ForecastViewModel(weatherService: MockWeatherService())
}

//
//  CacheManager.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Foundation
import Foundation

class CacheManager {
    static let shared = CacheManager()
    
    private let userDefaults = UserDefaults.standard
    private let cacheKey = "weatherCache"
    private let citiesCacheKey = "citiesCache"
    
    private init() {}
    
    // Read
    func getForecast() -> Forecast? {
        if let data = userDefaults.data(forKey: cacheKey),
           let forecast = try? JSONDecoder().decode(Forecast.self, from: data) {
            return forecast
        }
        return nil
    }
    
    // Write
    func cacheForecast(_ data: Forecast) {
        if let encodedData = try? JSONEncoder().encode(data) {
            userDefaults.set(encodedData, forKey: cacheKey)
        }
    }
    
    // Read array
    func getCitiesArray() -> [City]? {
        if let data = userDefaults.data(forKey: citiesCacheKey),
           let forecastArray = try? JSONDecoder().decode([City].self, from: data) {
            return forecastArray
        }
        return nil
    }
    
    // Write array
    func cacheCitiesArray(_ data: [City]) {
        if let encodedData = try? JSONEncoder().encode(data) {
            userDefaults.set(encodedData, forKey: citiesCacheKey)
        }
    }
    
    func addCityCache(_ city: City) {
        if let existingCacheArray = getCitiesArray() {
            var newCacheArray = existingCacheArray
            newCacheArray.append(city)
            self.cacheCitiesArray(newCacheArray)
        } else {
            self.cacheCitiesArray([city])
        }
    }
}

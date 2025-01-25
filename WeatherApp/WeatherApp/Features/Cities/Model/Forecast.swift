//
//  City.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation

struct Forecast: Codable {
    let name: String // City name
    let coord: Coordinates
    let weather: [Weather]
    let mainTemperature: MainTemperature // main
    let wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case name
        case coord
        case weather
        case mainTemperature = "main"
        case wind
    }
}

struct MainTemperature: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

struct Wind: Codable {
    let speed: Double
    let degrees: Double
    enum CodingKeys: String, CodingKey {
        case speed
        case degrees = "deg"
    }
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let main: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case description
    }
}

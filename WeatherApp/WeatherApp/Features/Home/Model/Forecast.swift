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
    let date: TimeInterval
    let systemData: SystemData
    let timezone: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case coord
        case weather
        case mainTemperature = "main"
        case wind
        case date = "dt"
        case systemData = "sys"
        case timezone
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

struct SystemData: Codable {
    let sunrise: TimeInterval
    let sunset: TimeInterval
    let country: String
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case description
        case icon
    }
}

//MARK: - Mocks

extension Forecast {
    static let mock = Forecast(name: "London",
                               coord: Coordinates.mock,
                               weather: [Weather.mock],
                               mainTemperature: MainTemperature.mock,
                               wind: Wind.mock,
                               date: .zero,
                               systemData: SystemData.mock,
                               timezone: 0)
}

extension Coordinates {
    static let mock = Coordinates(lon: -0.1257, lat: 51.5085) // London
}

extension Weather {
    static let mock = Weather(main: "Clouds", description: "broken clouds", icon: "04d")
}

extension SystemData {
    static let mock = SystemData(sunrise: 1737877638, sunset: 1737909514, country: "GB")
}

extension Wind {
    static let mock = Wind(speed: 4.63, degrees: 140)
}

extension MainTemperature {
    static let mock = MainTemperature(temp: 3.85, feelsLike: 0.06, tempMin: 2.3, tempMax: 4.74, humidity: 84)
}

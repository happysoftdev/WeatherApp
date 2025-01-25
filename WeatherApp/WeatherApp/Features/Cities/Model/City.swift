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

//struct City: Codable {
//    let name: String
//    let coord: Coordinates
//    let weather: [Weather]
//    
//    enum CodingKeys: String, CodingKey {
//        case name
//        case coord
//        case weather
//    }
//}
//extension City {
//    static let mock = City(name: "Manhanttenstur", coord: Coordinates.mock, weather: [Weather.mock])
//}
//
struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}
//extension Coordinates {
//    static let mock = Coordinates(lon: 51, lat: 12)
//}
//
struct Weather: Codable {
    let main: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case description
    }
}
//
//extension Weather {
//    static let mock = Weather(main: "Cloud", description: "More info that it's cloudy")
//}

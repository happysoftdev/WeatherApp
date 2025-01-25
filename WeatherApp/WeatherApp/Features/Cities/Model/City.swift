//
//  City.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation

struct City: Codable {
    let name: String
    let coord: Coordinates
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case name
        case coord
        case weather
    }
}
extension City {
    static let mock = City(name: "Manhanttenstur", coord: Coordinates.mock, weather: [Weather.mock])
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}
extension Coordinates {
    static let mock = Coordinates(lon: 51, lat: 12)
}

struct Weather: Codable {
    let main: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case description
    }
}

extension Weather {
    static let mock = Weather(main: "Cloud", description: "More info that it's cloudy")
}

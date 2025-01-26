//
//  City.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Foundation

struct City: Codable {
    let name: String
    let temperature: Int
    let forecast: Forecast?
    
    enum CodingKeys: CodingKey {
        case name
        case temperature
        case forecast
    }
    
    // saving when accessing data
    init(forecast: Forecast) {
        self.name = forecast.name
        self.temperature = Int(forecast.mainTemperature.temp)
        self.forecast = forecast
    }
    
    // for the default cities
    init(name: String) {
        self.name = name
        self.temperature = 0
        self.forecast = nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.temperature = try container.decode(Int.self, forKey: .temperature)
        self.forecast = try container.decodeIfPresent(Forecast.self, forKey: .forecast)
    }
    
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.temperature, forKey: .temperature)
        try container.encodeIfPresent(self.forecast, forKey: .forecast)
    }
}

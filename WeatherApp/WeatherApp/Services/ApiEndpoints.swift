//
//  ApiService.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation

class ApiEndpoints {
    static let apiKey = "55d3b00d9ec14f573cb1ae24908a0d11"
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    static let iconBaseURL = "https://openweathermap.org/img/wn/"
    
    static func iconURL(code: String) -> URL? {
        var urlString = iconBaseURL
        urlString.append(contentsOf: "\(code).png")
        return URL(string: urlString)
    }
    
    static func weather(with queryParameters: [URLQueryItem]) -> URL? {
        if var components = URLComponents(string: baseURL) {
            var parameters = queryParameters
            parameters.append(URLQueryItem(name: "appid", value: apiKey))
            components.queryItems = parameters
            return components.url
        }
        return nil
    }
}

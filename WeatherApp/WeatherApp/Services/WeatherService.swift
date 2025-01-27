//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Foundation
import Combine

// DI -> mocking -> reusability
protocol WeatherServiceProtocol: AnyObject {
    func fetchWeather(for city: String, unit: String?) -> AnyPublisher<Forecast, Error>
    func fetchWeather(with lat: Double, and lon: Double, unit: String?) -> AnyPublisher<Forecast, Error>
}

class MockWeatherService: WeatherServiceProtocol {
    
    func fetchWeather(for city: String, unit: String? = "metric") -> AnyPublisher<Forecast, Error> {
        let weatherForecast = Forecast.mock
        return Just(weatherForecast)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchWeather(with lat: Double, and lon: Double, unit: String? = "metric") -> AnyPublisher<Forecast, Error> {
        let weatherForecast = Forecast.mock
        return Just(weatherForecast)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class WeatherService: WeatherServiceProtocol {
    
    func fetchWeather(for city: String, unit: String? = "metric") -> AnyPublisher<Forecast, Error> {
        let parameters: [URLQueryItem] = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "units", value: unit)
        ]
        
        let url = ApiEndpoints.weather(with: parameters)
        return makeRequest(url: url, method: "GET", type: Forecast.self)
    }
    
    func fetchWeather(with lat: Double, and lon: Double, unit: String? = "metric") -> AnyPublisher<Forecast, Error> {
        let parameters: [URLQueryItem] = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "units", value: unit)
        ]
        
        let url = ApiEndpoints.weather(with: parameters)
        return makeRequest(url: url, method: "GET", type: Forecast.self)
    }
    
    private func makeRequest<T: Decodable>(url: URL?,
                                           method: String,
                                           body: Data? = nil,
                                           type: T.Type) -> AnyPublisher<T, Error> {
        guard let url = url else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

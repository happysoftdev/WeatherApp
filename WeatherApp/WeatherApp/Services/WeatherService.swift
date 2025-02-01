//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Foundation
import Combine
import CoreLocation

enum ServiceError: Error {
    case invalidURL
}

// IMPROVEMENT: use CLLocationCoordinates as parameters
// DI -> mocking -> reusability
protocol WeatherServiceProtocol: AnyObject {
    func fetchWeather(for city: String, unit: String?) -> AnyPublisher<Forecast, Error>
    func fetchWeather(with lat: Double, and lon: Double, unit: String?) -> AnyPublisher<Forecast, Error>
}


// MARK: - Mock service
class MockWeatherService: WeatherServiceProtocol {
    var shouldReturnError = false
    var mockForecast: Forecast?
    
    enum MockServiceError: Error {
        case someError
        case noData
    }
    
    func fetchWeather(for city: String, unit: String? = "metric") -> AnyPublisher<Forecast, Error> {
        return makeRequest()
    }
    
    func fetchWeather(with lat: Double, and lon: Double, unit: String? = "metric") -> AnyPublisher<Forecast, Error> {
        return makeRequest()
    }
    
    private func makeRequest() -> AnyPublisher<Forecast, Error> {
        if shouldReturnError {
            return Fail(error: MockServiceError.someError).eraseToAnyPublisher()
        } else if let mockForecast = mockForecast {
            return Just(mockForecast)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: MockServiceError.noData).eraseToAnyPublisher()
        }
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
            return Fail(error: ServiceError.invalidURL).eraseToAnyPublisher()
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
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

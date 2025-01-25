//
//  ApiService.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation
import Combine

class ApiEndpoints {
    static let apiKey = "55d3b00d9ec14f573cb1ae24908a0d11"
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    static func weather(lat: Double, lon: Double) -> URL? {
        if var components = URLComponents(string: baseURL) {
            components.queryItems = [
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "lat", value: String(lat)),
                URLQueryItem(name: "lon", value: String(lon)),
                URLQueryItem(name: "units", value: "metric"),
            ]
            return components.url
        }
        return nil
    }
    
    static func weather(locationName: String) -> URL? {
        if var components = URLComponents(string: baseURL) {
            components.queryItems = [
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "q", value: locationName),
                URLQueryItem(name: "units", value: "metric")
            ]
            return components.url
        }
        return nil
    }
    
    // REFACTORING: use this - send query params from elsewhere because you want to get data using coordinates / city name
    static func weather(with queryParameters: [URLQueryItem]) -> URL? {
        if var components = URLComponents(string: baseURL) {
            components.queryItems = queryParameters
            return components.url
        }
        return nil
    }
}

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

//REFACTORING: use this
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}

class ApiService {
    static let shared = ApiService()
    private init() {}
    
    private func makeRequest<T: Decodable>(url: URL?, method: String, body: Data? = nil, type: T.Type) -> AnyPublisher<T, Error> {
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
    
    func get<T: Codable>(url: URL?, type: T.Type) -> AnyPublisher<T, Error> {
        return makeRequest(url: url, method: "GET", type: type)
    }
}


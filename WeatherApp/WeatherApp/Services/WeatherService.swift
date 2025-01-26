//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Foundation

struct WeatherData: Decodable {
    let temperature: Double
    let description: String
}

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> WeatherData
}

class WeatherService: WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> WeatherData {
        // Simulated network call
        await Task.sleep(1_000_000_000) // 1 second delay
        return WeatherData(temperature: 22.5, description: "Sunny")
    }
}

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var temperature: String = ""
    @Published var description: String = ""
    @Published var isLoading: Bool = false

    // DI
    private let weatherService: WeatherServiceProtocol

    // DI
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    func getWeather() async {
        guard !city.isEmpty else { return }
        isLoading = true
        do {
            let weather = try await weatherService.fetchWeather(for: city)
            temperature = "\(weather.temperature)°C"
            description = weather.description
        } catch {
            temperature = "Error"
            description = "Could not fetch weather."
        }
        isLoading = false
    }
}

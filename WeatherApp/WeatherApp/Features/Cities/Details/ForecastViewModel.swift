//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation
import Combine
import CoreLocation

class ForecastViewModel: ObservableObject {
    @Published var forecast: Forecast? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var iconCode: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = ApiService.shared
    
    // mocking
    init(forecast: Forecast? = nil) {
        self.forecast = forecast
    }
    
    func fetch(lat: Double? = nil, lon: Double? = nil, locationName: String? = nil, unit: String? = nil) {
        
        self.isLoading = true
        self.errorMessage = nil
        
        var parameters: [URLQueryItem] = []
        
        // REFACTORING: move this outside + test it
        if let locationName = locationName {
            parameters.append(URLQueryItem(name: "q", value: locationName))
        } else if let lat = lat, let lon = lon {
            parameters.append(contentsOf: [
                    URLQueryItem(name: "lat", value: String(lat)),
                    URLQueryItem(name: "lon", value: String(lon))
                ]
            )
        }
        
        // REFACTORING: move this outside + test it
        if let unit = unit {
            if unit == "Celsius" {
                parameters.append(URLQueryItem(name: "units", value: "metric"))
            } else if unit == "Fahrenheit" {
                parameters.append(URLQueryItem(name: "units", value: "imperial"))
            }
        }
        
        let url = ApiEndpoints.weather(with: parameters)
        
        apiService.get(url: url, type: Forecast.self)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                
                switch completion {
                case .failure(let err):
                    self?.isLoading = false
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Success")
                }
            } receiveValue: { [weak self] response in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self?.isLoading = false
                    self?.forecast = response
                    self?.iconCode = response.weather.first?.icon
                }
            } .store(in: &cancellables)
    }
}

extension ForecastViewModel {
    static let mock = ForecastViewModel(forecast: Forecast.mock)
}

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
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = ApiService.shared
    
    func fetch(for lat: Double, and lon: Double) {
        self.isLoading = true
        self.errorMessage = nil
        
        let url = ApiEndpoints.weather(lat: lat, lon: lon)
        
        apiService.get(url: url, type: Forecast.self)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Success")
                }
            } receiveValue: { [weak self] response in
                self?.forecast = response
            } .store(in: &cancellables)
    }
    
    func fetch(for locationName: String) {
        self.isLoading = true
        self.errorMessage = nil
        
        let url = ApiEndpoints.weather(locationName: locationName)
        
        apiService.get(url: url, type: Forecast.self)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Success")
                }
            } receiveValue: { [weak self] response in
                self?.forecast = response
            } .store(in: &cancellables)
    }
}

//
//  DetailsView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI
import Combine
import CoreLocation

class CityForecastViewModel: ObservableObject {
    @Published var city: City? = City.mock
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = ApiService.shared
    
    func fetch() {
        self.isLoading = true
        self.errorMessage = nil
        
        let url = ApiEndpoints.weather2(lat: 51.5, lon: -0.11)
        apiService.get(url: url, type: City.self)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] response in
                self?.city = response
            } .store(in: &cancellables)
    }
    
    func fetch(for location: CLLocationCoordinate2D) {
        self.isLoading = true
        self.errorMessage = nil
        
        let url = ApiEndpoints.weather2(lat: location.latitude, lon: location.longitude)
        apiService.get(url: url, type: City.self)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] response in
                self?.city = response
            } .store(in: &cancellables)
    }
}

struct DetailsView: View {
    
    @StateObject var viewModel = CityForecastViewModel()
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                Text(viewModel.city?.name ?? "default title")
                    .font(.headline)
            }
        }
        .navigationTitle("City details")
        .onAppear {
            viewModel.fetch()
        }
    }
}

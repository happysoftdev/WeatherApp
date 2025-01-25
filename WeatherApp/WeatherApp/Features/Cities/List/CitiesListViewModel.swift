//
//  CitiesListViewModel.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation
import Combine

// London : lat 51.50, lon -0.11

class CitiesListViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
}


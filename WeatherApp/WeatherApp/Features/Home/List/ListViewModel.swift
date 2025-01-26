//
//  CitiesListViewModel.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation
import Combine

//TODO: Make this take care of requesting location & display data only after requesting location so that all data appears at the same time
class ListViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
}


//
//  ListView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI

struct ListView: View {
    
    @StateObject private var viewModel = CitiesListViewModel()
    
    var body: some View {
        DetailsView()
    }
}

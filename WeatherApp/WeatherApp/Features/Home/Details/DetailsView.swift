//
//  DetailsView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI

struct DetailsView: View {
    
    @StateObject var viewModel: ForecastViewModel
    
    // set up by HomeCoordinator
    var city: String? = nil
    var latitude: Double? = nil
    var longitude: Double? = nil
    
    // called by HomeCoordinator
    init(viewModel: ForecastViewModel, city: String? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
            
            VStack(alignment: .center) {
                if viewModel.isLoading {
                    CircularProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.callout)
                } else {
                    WeatherInfoView(viewModel: viewModel)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    textView(text: "Current Weather", font: .headline)
                }
            }
            .tint(.white)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchData(lat: latitude, lon: longitude, city: city)
            }
        }
    }
}


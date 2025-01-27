//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import SwiftUI

struct WeatherInfoView: View {
    @ObservedObject var viewModel: ForecastViewModel
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Location Name
            textView(text: viewModel.locationName, font: .largeTitle)
                .bold()
            
            // Current Temperature
            textView(text: viewModel.temperature, font: .system(size: 64))
                .bold()
            
            // Feels like
            textView(text: viewModel.feelsLike, font: .title2)
            
            // Min & Max
            HStack {
                VStack(alignment: .leading) {
                    textView(text: "Min", font: .caption)
                    textView(text: viewModel.minTemp, font: .headline)
                }
                VStack(alignment: .trailing) {
                    textView(text: "Max", font: .caption)
                    textView(text: viewModel.maxTemp, font: .headline)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.3))
            .cornerRadius(12)
            .shadow(radius: 5)
            
            // Weather Condition
            textView(text: viewModel.condition, font: .title2)
            
            // Weather Condition
            textView(text: viewModel.conditionDescription, font: .title2)
            
            // Weather Icon
            if let iconCode = viewModel.iconCode, let url = ApiEndpoints.iconURL(code: iconCode) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "cloud.sun.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.white)
            }
            
            WeatherAdditionalInfoView(viewModel: viewModel)
            
            Spacer()
            textView(text: "Last updated at: \(viewModel.lastUpdatedAt)", font: .subheadline)
                .fontWeight(.medium)
        }
        .padding()
    }
}

#Preview {
    WeatherInfoView(viewModel: .mock)
}

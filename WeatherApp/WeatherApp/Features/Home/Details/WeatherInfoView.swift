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

//            // Min & Max
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
            
            WeatherAdditionalDetailsView(viewModel: viewModel)
            
            Spacer()
            textView(text: "Last updated at: \(viewModel.lastUpdatedAt)", font: .subheadline)
                .fontWeight(.medium)
        }
        .padding()
    }
    
   
}

extension View {
    @ViewBuilder
    func textView(text: String, font: Font, textColor: Color = .white) -> Text {
        Text(text)
            .font(font)
            .foregroundColor(textColor)
    }
}

struct WeatherAdditionalDetailsView: View {
    @ObservedObject var viewModel: ForecastViewModel
    var body: some View {
        VStack {
            // Humidity & Wind speed
            HStack {
                VStack(alignment: .leading) {
                    textView(text: "Humidity", font: .headline, textColor: .black)
                    textView(text: viewModel.humidity, font: .subheadline, textColor: .black)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    textView(text: "Wind Speed", font: .headline, textColor: .black)
                    textView(text: viewModel.windSpeed, font: .subheadline, textColor: .black)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(radius: 5)
            
            //IMPROVEMENT: Sunrise & Sunset - create a line between them
            HStack {
                VStack(alignment: .leading) {
                    textView(text: "Sunrise", font: .headline, textColor: .black)
                    textView(text: viewModel.sunrise, font: .subheadline, textColor: .black)
                }
                Spacer()
                VStack(alignment: .leading) {
                    textView(text: "Sunset", font: .headline, textColor: .black)
                    textView(text: viewModel.sunset, font: .subheadline, textColor: .black)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(radius: 5)
        }
    }
}

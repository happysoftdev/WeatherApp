//
//  WeatherAdditionalInfoView.swift
//  WeatherApp
//
//  Created by Patricia on 27.01.2025.
//

import SwiftUI

struct WeatherAdditionalInfoView: View {
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

#Preview {
    WeatherAdditionalInfoView(viewModel: .mock)
}

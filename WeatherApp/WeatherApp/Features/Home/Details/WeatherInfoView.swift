//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import SwiftUI

struct WeatherInfoView: View {
    @ObservedObject var viewModel: ForecastViewModel
    @AppStorage("unit") private var unit: TemperatureUnit = .celsius
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Location Name
            textView(text: viewModel.forecast?.name ?? "No location", font: .largeTitle)
                .bold()
            
            // Current Temperature
            textView(text: "\(Int((viewModel.forecast?.mainTemperature.temp) ?? 0))°\(unitString())", font: .system(size: 64))
                .bold()
            
            // Feels like
            textView(text:" Feels like \(Int((viewModel.forecast?.mainTemperature.feelsLike) ?? 0))°\(unitString())", font: .title2)
            
            // Min & Max
            HStack {
                VStack {
                    textView(text: "Min", font: .caption)
                    textView(text: "\(Int((viewModel.forecast?.mainTemperature.tempMin) ?? 0))°\(unitString())", font: .headline)
                }
                VStack {
                    textView(text: "Max", font: .caption)
                    textView(text: "\(Int((viewModel.forecast?.mainTemperature.tempMax) ?? 0))°\(unitString())", font: .headline)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.3))
            .cornerRadius(12)
            .shadow(radius: 5)
            
            // Weather Condition
            textView(text: viewModel.forecast?.weather.first?.main ?? "", font: .title2)
            
            // Weather Condition
            textView(text: viewModel.forecast?.weather.first?.description ?? "", font: .title2)
            
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
    
    func unitString() -> String { return unit == .celsius ? "C" : "F" }
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
                    Text("Humidity")
                        .font(.headline)
                    Text("\(String(describing: viewModel.forecast?.mainTemperature.humidity ?? 0))%")
                        .font(.subheadline)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Wind Speed")
                        .font(.headline)
                    Text("\(viewModel.forecast?.wind.speed ?? 0, specifier: "%.1f") m/s")
                        .font(.subheadline)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(radius: 5)
            
            //IMPROVEMENT: Sunrise & Sunset - create a line between them
            HStack {
                VStack(alignment: .leading) {
                    Text("Sunrise")
                        .font(.headline)
                    Text("\(String(describing: viewModel.sunrise))")
                        .font(.subheadline)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Sunset")
                        .font(.headline)
                    Text("\(String(describing: viewModel.sunset))")
                        .font(.subheadline)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(radius: 5)
        }
    }
}

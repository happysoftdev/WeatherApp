//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import SwiftUI

struct WeatherInfoView: View {
    @ObservedObject var viewModel: ForecastViewModel
    @State var textColor: Color = .white
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Location Name
            Text(viewModel.forecast?.name ?? "No location")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(textColor)
            
            // Current Temperature
            Text("\(Int((viewModel.forecast?.mainTemperature.temp) ?? 0))°C")
                .font(.system(size: 64))
                .bold()
                .foregroundStyle(textColor)
           
            // Feels like
            Text("Feels like \(Int((viewModel.forecast?.mainTemperature.feelsLike) ?? 0))°C")
                .font(.title2)
                .foregroundStyle(textColor)
            
            // Min & Max
            HStack {
                VStack {
                    Text("Min")
                        .font(.caption)
                        .foregroundColor(textColor)
                    Text("\(Int((viewModel.forecast?.mainTemperature.tempMin) ?? 0))°C")
                        .font(.headline)
                        .foregroundColor(textColor)
                }
                VStack {
                    Text("Max")
                        .font(.caption)
                        .foregroundColor(textColor)
                    Text("\(Int((viewModel.forecast?.mainTemperature.tempMax) ?? 0))°C")
                        .font(.headline)
                        .foregroundColor(textColor)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.3))
            .cornerRadius(12)
            .shadow(radius: 5)
            
            // Weather Condition
            Text(viewModel.forecast?.weather.first?.main ?? "")
                .font(.title2)
                .foregroundStyle(textColor)
            
            // Weather Condition
            Text(viewModel.forecast?.weather.first?.description ?? "")
                .font(.title2)
                .foregroundStyle(textColor)
            
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
                    .foregroundStyle(textColor)
            }
            
            WeatherAdditionalDetailsView(viewModel: viewModel)
            
            Spacer()
        }
        .padding()
    }
}


#Preview {
    ZStack {
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
        WeatherInfoView(viewModel: ForecastViewModel.mock)
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
                    Text("\(String(describing: viewModel.forecast?.mainTemperature.humidity))%")
                        .font(.subheadline)
                }
                Spacer()
                VStack(alignment: .leading) {
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
            
            // TODO: Sunrise & Sunset - maybe a line between them
            HStack {
                VStack(alignment: .leading) {
                    Text("Sunrise")
                        .font(.headline)
                    Text("\(String(describing: viewModel.forecast?.mainTemperature.humidity))%")
                        .font(.subheadline)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Sunset")
                        .font(.headline)
                    Text("\(viewModel.forecast?.wind.speed ?? 0, specifier: "%.1f") m/s")
                        .font(.subheadline)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(radius: 5)
            
            // TODO: Last updated at: dt
        }
    }
}

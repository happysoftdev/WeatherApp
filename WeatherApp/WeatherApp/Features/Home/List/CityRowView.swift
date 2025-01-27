//
//  CityRowView.swift
//  WeatherApp
//
//  Created by Patricia on 27.01.2025.
//

import SwiftUI

struct CityRowView: View {
    let icon: String
    let name: String
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(.yellow)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
    }
}


#Preview {
    CityRowView(icon: "sun.max.fill", name: "Rome")
}

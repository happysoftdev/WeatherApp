//
//  ListView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI

struct ListView: View {
    let defaultCities: [String] = ["Tokyo", "Rome", "London"]
    var body: some View {
        List(defaultCities, id: \.self) { city in
            Text(city)
        }
    }
}

#Preview {
    ListView()
}

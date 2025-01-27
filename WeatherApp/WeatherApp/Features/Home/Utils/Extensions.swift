//
//  Extensions.swift
//  WeatherApp
//
//  Created by Patricia on 27.01.2025.
//

import SwiftUI

struct GradientBackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green.opacity(0.4)]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
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

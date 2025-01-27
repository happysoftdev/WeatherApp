//
//  CircularProgressView.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import SwiftUI

struct CircularProgressView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(.white.opacity(0.3))
                .frame(width: 80, height: 80)

            Circle()
                .trim(from: 0, to: 0.7) // Arc from 0% to 70%
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [.blue, .purple]),
                                    center: .center),
                    style: StrokeStyle(lineWidth: 5,
                                       lineCap: .round)
                )
                .frame(width: 80, height: 80)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(
                    Animation
                    .linear(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: isAnimating
                )
        }
        .onAppear {
            isAnimating = true
        }
    }
}

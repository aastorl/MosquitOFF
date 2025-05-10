//
//  HomeView+Preview.swift
//  MosquitOFF
//
//  Created by Astor Ludueña on 06/05/2025.
//

import SwiftUI

struct MockHomeView: View {
    let mockWeather = WeatherData(temperature: 30, humidity: 80, condition: "Cloudy")

    var body: some View {
        ZStack {
            backgroundImageForCondition(mockWeather.condition)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 6)

            MosquitoAnimationView(risk: mosquitoRisk(for: mockWeather))

            VStack(spacing: 20) {
                Text("🦟 MosquitOFF")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()

                Text("🌡 Temp: \(mockWeather.temperature, specifier: "%.1f")°C")
                    .foregroundColor(.white)
                    .font(.title2)

                Text("💧 Humidity: \(mockWeather.humidity, specifier: "%.0f")%")
                    .foregroundColor(.white)
                    .font(.title2)

                Text("☁️ Condition: \(mockWeather.condition)")
                    .foregroundColor(.white)
                    .font(.title2)

                Text("🦟 Mosquito Risk: \(mosquitoRisk(for: mockWeather))")
                    .bold()
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .padding()
        }
    }

    func mosquitoRisk(for data: WeatherData) -> String {
        switch (data.temperature, data.humidity) {
        case (25...40, 60...100): return "High"
        case (20..<25, 40..<60): return "Medium"
        default: return "Low"
        }
    }

    func backgroundImageForCondition(_ condition: String) -> Image {
        switch condition.lowercased() {
        case "sunny": return Image("sunny_bg")
        case "cloudy": return Image("cloudy_bg")
        case "rainy": return Image("rainy_bg")
        default: return Image("sunny_bg")
        }
    }
}

#Preview {
    MockHomeView()
}

// MARK: - Mosquito Animation View

struct MosquitoAnimationView: View {
    let count: Int

    init(risk: String) {
        switch risk {
        case "High": self.count = 30
        case "Medium": self.count = 15
        default: self.count = 5
        }
    }

    var body: some View {
        ZStack {
            ForEach(0..<count, id: \.self) { _ in
                Mosquito()
            }
        }
    }
}

struct Mosquito: View {
    @State private var x: CGFloat = CGFloat.random(in: 0...UIScreen.main.bounds.width)
    @State private var y: CGFloat = CGFloat.random(in: 0...UIScreen.main.bounds.height)

    var body: some View {
        Text("🦟")
            .font(.title2)
            .opacity(0.5)
            .position(x: x, y: y)
            .onAppear {
                withAnimation(
                    Animation.linear(duration: Double.random(in: 3...6))
                        .repeatForever(autoreverses: true)
                ) {
                    x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
                    y = CGFloat.random(in: 0...UIScreen.main.bounds.height)
                }
            }
    }
}

#Preview("Mosquito Animation") {
    MosquitoAnimationView(risk: "High")
}




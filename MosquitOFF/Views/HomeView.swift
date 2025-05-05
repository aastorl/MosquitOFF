//
//  HomeView.swift
//  MosquitOFF
//
//  Created by Astor Ludueña  on 05/05/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let weather = viewModel.weather {
                    Text("🌡 Temp: \(weather.temperature, specifier: "%.1f")°C")
                    Text("💧 Humidity: \(weather.humidity, specifier: "%.0f")%")
                    Text("☁️ Condition: \(weather.condition)")
                    
                    let risk = mosquitoRisk(for: weather)
                    Text("🦟 Mosquito Risk: \(risk)")
                        .bold()
                        .foregroundColor(riskColor(for: risk))
                } else {
                    ProgressView("Loading weather...")
                }
            }
            .padding()
            .navigationTitle("MosquitOFF")
        }
    }

    func mosquitoRisk(for data: WeatherData) -> String {
        switch (data.temperature, data.humidity) {
        case (25...40, 60...100): return "High"
        case (20..<25, 40..<60): return "Medium"
        default: return "Low"
        }
    }

    func riskColor(for risk: String) -> Color {
        switch risk {
        case "High": return .red
        case "Medium": return .orange
        default: return .green
        }
    }
}


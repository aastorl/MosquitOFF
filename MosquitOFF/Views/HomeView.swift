//
//  HomeView.swift
//  MosquitOFF
//
//  Created by Astor Ludueña  on 05/05/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var reports: [Report] = []
    private let reportManager = ReportManager()

    var body: some View {
        NavigationView {
            ZStack {
                if let weather = viewModel.weather {
                    backgroundImageForCondition(weather.condition)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .overlay(Color.black.opacity(0.2).ignoresSafeArea())
                        .blur(radius: isNightTime() ? 3 : 6)

                    mosquitoOverlay(for: mosquitoRisk(for: weather))
                }

                VStack(spacing: 20) {
                    Text("MosquitOFF")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.9), radius: 4, x: 0, y: 2)
                        .padding()

                    if let weather = viewModel.weather {
                        Text("🌡 Temperature: \(weather.temperature, specifier: "%.1f")°C")
                            .foregroundColor(.white)
                            .font(.title2)
                            .shadow(color: .black.opacity(0.8), radius: 3, x: 0, y: 1)

                        Text("💧 Humidity: \(weather.humidity, specifier: "%.0f")%")
                            .foregroundColor(.white)
                            .font(.title2)
                            .shadow(color: .black.opacity(0.8), radius: 3, x: 0, y: 1)

                        Text("☁️ Condition: \(weather.condition)")
                            .foregroundColor(.white)
                            .font(.title2)
                            .shadow(color: .black.opacity(0.8), radius: 3, x: 0, y: 1)

                        Text("🦟 Mosquito Risk: \(mosquitoRisk(for: weather))")
                            .bold()
                            .foregroundColor(.white)
                            .font(.title2)
                            .shadow(color: .black.opacity(0.8), radius: 3, x: 0, y: 1)

                        Button("🔔 Test Notification") {
                            NotificationManager.shared.sendDengueRiskNotification()
                        }
                        .padding()
                        .background(Color.yellow.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.6), radius: 3, x: 0, y: 2)
                        
                        Button("Test Daily Reminder") {
                            NotificationManager.shared.sendTestDailyReminder()
                        }
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)


                        Button(action: {
                            let newReport = Report(type: "Mosquito", description: "Mosquito avistado en la zona", timestamp: Date())
                            reports.append(newReport)
                            reportManager.saveReports(reports)
                        }) {
                            Text("Add Report")
                                .padding()
                                .background(Color.blue.opacity(0.9))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.6), radius: 3, x: 0, y: 2)
                        }

                        if mosquitoRisk(for: weather) == "High" {
                            Button("Send Dengue Risk Notification") {
                                NotificationManager.shared.sendDengueRiskNotification()
                            }
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.6), radius: 3, x: 0, y: 2)
                        }

                        NavigationLink(destination: ReportListView()) {
                            Text("View Reports")
                                .padding()
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.6), radius: 2, x: 0, y: 1)
                        }
                    } else {
                        ProgressView("Loading weather...")
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.8), radius: 2, x: 0, y: 1)
                    }
                }
                .padding()
                .navigationTitle("")
                .onAppear {
                    reports = reportManager.loadReports()
                    NotificationManager.shared.requestPermission()
                    NotificationManager.shared.scheduleDailyReminder()
                }
            }
        }
    }

    // MARK: - Helpers

    func mosquitoRisk(for data: WeatherData) -> String {
        let temp = data.temperature
        let humidity = data.humidity
        let condition = data.condition.lowercased()

        let isRainy = condition.contains("rain") || condition.contains("storm") || condition.contains("drizzle")

        if temp >= 25 && humidity >= 60 && isRainy {
            return "High"
        } else if temp >= 20 && humidity >= 40 {
            return "Medium"
        } else {
            return "Low"
        }
    }
    
    func isNightTime() -> Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour >= 19 || hour < 6
    }

    func backgroundImageForCondition(_ condition: String) -> Image {
        if isNightTime() {
            return Image("night_bg")
        }

        switch condition.lowercased() {
        case "sunny": return Image("sunny_bg")
        case "cloudy": return Image("cloudy_bg")
        case "rainy": return Image("rainy_bg")
        default: return Image("sunny_bg")
        }
    }


    func mosquitoOverlay(for risk: String) -> some View {
        let count: Int
        switch risk {
        case "High": count = 30
        case "Medium": count = 15
        default: count = 5
        }

        return ZStack {
            ForEach(0..<count, id: \.self) { _ in
                Text("🦟")
                    .font(.title2)
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                    )
                    .opacity(0.4)
            }
        }
    }
}









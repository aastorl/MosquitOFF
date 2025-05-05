//
//  WeatherViewModel.swift
//  MosquitOFF
//
//  Created by Astor Ludueña  on 05/05/2025.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherData?
    private let weatherService = WeatherService()
    private var locationManager = LocationManager()

    init() {
        locationManager.$location
            .compactMap { $0 }
            .first()
            .sink { [weak self] coordinate in
                self?.fetchWeather(lat: coordinate.latitude, lon: coordinate.longitude)
            }
            .store(in: &cancellables)
    }

    private var cancellables = Set<AnyCancellable>()

    func fetchWeather(lat: Double, lon: Double) {
        weatherService.fetchWeather(lat: lat, lon: lon) { [weak self] weather in
            self?.weather = weather
        }
    }
}


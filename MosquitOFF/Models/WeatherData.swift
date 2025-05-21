//
//  WeatherData.swift
//  MosquitOFF
//
//  Created by Astor Ludueña  on 05/05/2025.
//

import Foundation

struct WeatherData: Identifiable, Equatable {
    let id = UUID()
    let temperature: Double
    let humidity: Double
    let condition: String // "Sunny", "Cloudy", etc.

}


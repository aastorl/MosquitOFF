//
//  OpenWeatherResponse.swift
//  MosquitOFF
//
//  Created by Astor Ludueña  on 05/05/2025.
//

struct OpenWeatherResponse: Decodable {
    let weather: [Weather]
    let main: Main

    struct Weather: Decodable {
        let main: String
    }

    struct Main: Decodable {
        let temp: Double
        let humidity: Double
    }
}


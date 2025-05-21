//
//  WeatherService.swift
//  MosquitOFF
//
//  Created by Astor Ludueña  on 05/05/2025.
//

import Foundation
import CoreLocation

class WeatherService {
    let apiKey = "ecd27ae9b48df86066912ed7e837fe85"

    func fetchWeather(lat: Double, lon: Double, completion: @escaping (WeatherData?) -> Void) {
        let urlString =
        "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)&lang=es"
        
        guard let url = URL(string: urlString) else {
            print("❌ URL inválida")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(OpenWeatherResponse.self, from: data)
                    let weather = WeatherData(
                        temperature: decoded.main.temp,
                        humidity: decoded.main.humidity,
                        condition: decoded.weather.first?.main ?? "Desconocido"
                    )
                    DispatchQueue.main.async {
                        completion(weather)
                    }
                } catch {
                    print("❌ Error decoding:", error)
                    completion(nil)
                }
            } else {
                print("❌ Error en la petición:", error?.localizedDescription ?? "Desconocido")
                completion(nil)
            }
        }.resume()
    }
}


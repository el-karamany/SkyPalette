//
//  WeatherData.swift
//  SkyPalette
//
//  Created by Omar El-Karamany on 07/10/2023.
//

import UIKit

struct WeatherData: Codable {
    let name: String
    let visibility: Int
    let weather: [Weather]
    let main: Main
    let wind: Wind
    
}

struct Weather: Codable {
    let description:String
}


struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
}

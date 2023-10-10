//
//  WeatherModel.swift
//  SkyPalette
//
//  Created by Omar El-Karamany on 08/10/2023.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let temprature: Double
    let visibility: Int
    let humditiy: Int
    let description: String
    let minTemprature: Double
    let maxTemprature: Double
    let feelsLikes: Double
    let windSpeed: Double
    
    
    var tempString: String {
        return String(format: "%.0f", temprature)
    }
    
    var maxTempString: String {
        return String(format: "%.1f", maxTemprature)
    }
    
    var minTempString: String {
        return String(format: "%.1f", minTemprature)
    }
    
    var feelsLikeString: String {
        return String(format: "%.1f", feelsLikes)
    }
    
    var humidityString: String {
        return String(humditiy)
    }
    
    var visibilityString: String {
        return String("\(visibility / 1000)")
    }
    
    var windSpeedString: String {
        return String(format: "%.1f", windSpeed)
    }
    
    
}

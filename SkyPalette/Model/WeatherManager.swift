//
//  WeatherManager.swift
//  SkyPalette
//
//  Created by Omar El-Karamany on 06/10/2023.
//

import Foundation

protocol WeatherDataDelegate {
    func updateWeatherData(_ weatherManager: WeatherManager, _ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    private let apiID = ""
    private let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=87c03502625f2feec3d8f73059981b93&units=metric"
    var delegate: WeatherDataDelegate?
    
    func fetchWeatherData(_ city: String) {
        let url = "\(weatherUrl)&q=\(city)"
        //print(url)
        perfromWeatherTask(url)
    }
    
    func fetchcurrentLocationWeatherData(_ latitude: Double, _ longitude: Double) {
        let url = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        perfromWeatherTask(url)
    }
    
    
    func perfromWeatherTask (_ url: String) {
        
        
        //create url
        if let url = URL(string: url) {
            //create url session
            let session = URLSession(configuration: .default)
            
            //create task
            let task = session.dataTask(with: url, completionHandler: {(data, urlResponse, error) in
                if error != nil {
                    delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        delegate?.updateWeatherData(self, weather)
                    }
                }
            })
            
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weather = WeatherModel(cityName: decodedData.name, temprature: decodedData.main.temp,
                                       visibility: decodedData.visibility, humditiy: decodedData.main.humidity,
                                       description: decodedData.weather[0].description, minTemprature: decodedData.main.temp_min,
                                       maxTemprature: decodedData.main.temp_max, feelsLikes: decodedData.main.feels_like,
                                       windSpeed: decodedData.wind.speed)
            
            return weather
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
}

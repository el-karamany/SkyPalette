//
//  ViewController.swift
//  SkyPalette
//
//  Created by Omar El-Karamany on 06/10/2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
      
    //WeatherManager object
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    //Labels
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var weatherDegree: UILabel!
    @IBOutlet weak var dailySummary: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var humidityPercentage: UILabel!
    @IBOutlet weak var visibilityRange: UILabel!
    
    
    //TextFields
    @IBOutlet weak var searchTextField: UITextField!
    
    
    //Buttonsi
    @IBOutlet weak var SearchBtn: UIButton!
    @IBOutlet weak var CrntLocationBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding corner radius
        searchTextField.layer.cornerRadius = 10
        SearchBtn.layer.cornerRadius = 10
        CrntLocationBtn.layer.cornerRadius = 10
        
        
        //SearchTextField Inside padding
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: searchTextField.frame.height))
        searchTextField.leftViewMode = UITextField.ViewMode.always
        
        //Notifying the view of changes to the textField
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        //Location Access
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyReduced
        locationManager.requestLocation()
     
 
    }
    
    @IBAction func currentLocationAction(_ sender: UIButton) {
        locationManager.desiredAccuracy = kCLLocationAccuracyReduced
        locationManager.requestLocation()
    }
    
}


//MARK: - TextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text {
            weatherManager.fetchWeatherData(city)
        }

        textField.placeholder = "Enter a city Name"
        textField.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherDataDelegate {
    
    func updateWeatherData(_ weatherManager: WeatherManager, _ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityName.text = weather.cityName
            self.weatherCondition.text = weather.description
            self.weatherDegree.text = " \(weather.tempString)°"
            self.dailySummary.text = "Now it feels like \(weather.feelsLikeString)°, and the temperature is felt in the range from \(weather.minTempString)° to \(weather.maxTempString)°"
            self.windSpeed.text = "\(weather.windSpeedString)Km"
            self.humidityPercentage.text = "\(weather.humidityString)%"
            self.visibilityRange.text = "\(weather.visibilityString)Km"
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//MARK: - CLlocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            print("Latitude: \(location.coordinate.latitude), Lontitude: \(location.coordinate.longitude)")
            weatherManager.fetchcurrentLocationWeatherData(location.coordinate.latitude, location.coordinate.longitude)
        }
       
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}




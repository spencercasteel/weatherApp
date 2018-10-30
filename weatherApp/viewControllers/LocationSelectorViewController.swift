//
//  LocationSelectorViewController.swift
//  weatherApp
//
//  Created by Spencer Casteel on 10/26/18.
//  Copyright © 2018 Spencer Casteel. All rights reserved.
//

import UIKit

class LocationSelectorViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    let apiManager = APIManager()
    
    var geocodingData: GeoCodingData?
    var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSearchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func handleError() {
        geocodingData = nil
        weatherData = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            return
        }
        retrieveGeocodingData(searchAddress: searchAddress)
    }
    
    func retrieveWeatherData(latitude: Double, longitude: Double) {
        apiManager.getWeather(latitude: latitude, longitude: longitude) { (receivedWeatherData, error) in
            if let receivedError = error {
                print(receivedError.localizedDescription)
                self.handleError()
                return
            }
            if let receivedData = receivedWeatherData{
                self.weatherData = receivedData
                self.performSegue(withIdentifier: "unwindToWeatherDisplay", sender: self)
            } else {
                self.handleError()
                return
            }
        }
    }
    
    func retrieveGeocodingData(searchAddress: String) {
        apiManager.geocode(address: searchAddress) { (geocodingData, error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
            
            if let recivedData = geocodingData {
                self.geocodingData = recivedData
                self.retrieveWeatherData(latitude: recivedData.latitude, longitude: recivedData.longitude)
            } else {
                self.handleError()
                return
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? WeatherDisplayViewController, let retreivedGeocodingData = geocodingData, let retrievedWeatherData = weatherData {
            destinationVC.displayGeocodingData = retreivedGeocodingData
            destinationVC.displayWeatherData = retrievedWeatherData
        }
    }
}

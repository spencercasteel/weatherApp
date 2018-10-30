//
//  APIManager.swift
//  weatherApp
//
//  Created by Spencer Casteel on 10/29/18.
//  Copyright © 2018 Spencer Casteel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    
    //base URL for Dark Sky API
    private let darkSkyURL = "https://api.darksky.net/forecast/"
    
    //Base URL for the google Geocoding API
    private let googleBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
    
    //Instance of the APIKeys struct
    private let apiKeys = APIKeys()
    
    //enum containing different errors we could get from trying to connect to an API
    enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
    }
    
    func getWeather(latitude: Double, longitude: Double, onCompletion: @escaping (WeatherData?, Error?) -> Void) {
       
        let url = darkSkyURL + apiKeys.darkSkyKey + "/" + "\(latitude)" + "," + "\(longitude)"
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //if the json can be converted into geocoding data, call the completion closure by passing in the geocoding data and nil for the error
                if let weatherData = WeatherData(json: json) {
                    onCompletion(weatherData, nil)
                } else {
                    onCompletion(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
    }
    
    func geocode(address: String, onCompletion: @escaping(GeoCodingData?, Error?) -> Void) {
        
        let url = googleBaseURL + address + "&key=" + apiKeys.googleKey
        
        let request = Alamofire.request(url)
        
        request.responseJSON { respose in
            switch respose.result {
            case .success(let value):
                let json = JSON(value)
                //if the json can be converted into geocoding data, call the completion closure by passing in the geocoding data and nil for the error
                if let geocodingData = GeoCodingData(json: json) {
                    onCompletion(geocodingData, nil)
                } else {
                    onCompletion(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
    }
}

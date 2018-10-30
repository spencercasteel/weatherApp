//
//  WeatherData.swift
//  weatherApp
//
//  Created by Spencer Casteel on 10/26/18.
//  Copyright © 2018 Spencer Casteel. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherData {
    
    enum WeatherDataKeys: String {
        case currently = "currently"
        case temperature = "temperature"
        case icon = "icon"
        case daily = "daily"
        case data = "data"
        case temperatureHigh = "temperatureHigh"
        case temperatureLow = "temperatureLow"
    }
    
    //Mark:- Types
    
    enum Condition: String {
        case clearDay = "clear-day"
        case clearnight = "clear-night"
        case rain = "rain"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        case partlyCloudyDay = "partly-cloudy-day"
        case partlyCloudyNight = "partly-cloudy-night"
        
        var icon: String {
            switch self {
            case .clearDay:
                return "☀️"
            case .clearnight:
                return "🌙"
            case .rain:
                return "☔️"
            case .snow:
                return "❄️"
            case .sleet:
                return "🌨"
            case .wind:
                return "💨"
            case .fog:
                return "🌫"
            case .cloudy:
                return "☁️"
            case .partlyCloudyDay:
                return "⛅️"
            case .partlyCloudyNight:
                return "☁️"
            }
        }
    }
    
    //MARK:- Properties
    
    let temp: Double
    let lowTemp: Double
    let highTemp: Double
    let condition: Condition
    
    //Mark:- Methods
    
    init(temp: Double, highTemp: Double, lowTemp: Double, condition: Condition) {
        self.temp = temp
        self.highTemp = highTemp
        self.lowTemp = lowTemp
        self.condition = condition
    }
    
    convenience init?(json: JSON) {
        guard let temperature = json[WeatherDataKeys.currently.rawValue][WeatherDataKeys.temperature.rawValue].double else {
            return nil
        }
        
        guard let highTempature = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureHigh.rawValue].double else {
            return nil
        }
        
        guard let lowTempature = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureLow.rawValue].double else {
            return nil
        }
        
        guard let conditionString = json[WeatherDataKeys.currently.rawValue][WeatherDataKeys.icon.rawValue].string else {
            return nil
        }
        
        guard let condition = Condition(rawValue: conditionString) else {
            return nil
        }
        
        self.init(temp: temperature, highTemp: highTempature, lowTemp: lowTempature, condition: condition)
        
    }
}

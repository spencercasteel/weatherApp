//
//  WeatherDisplayViewController.swift
//  weatherApp
//
//  Created by Spencer Casteel on 10/24/18.
//  Copyright © 2018 Spencer Casteel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherDisplayViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    var displayWeatherData: WeatherData!{
        didSet {
            iconLabel.text = displayWeatherData.condition.icon
            currentTempLabel.text = "\(displayWeatherData.temp)º"
            highTempLabel.text = "\(displayWeatherData.highTemp)º"
            lowTempLabel.text = "\(displayWeatherData.lowTemp)º"
        }
    }
    
    var displayGeocodingData: GeoCodingData! {
        didSet{
            locationLabel.text = displayGeocodingData.formattedAddress
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupDefaultUI()
        
        let apiManager = APIManager()
        
        apiManager.geocode(address: "glasgow,+kentucky") { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
            print(data.formattedAddress)
            print(data.latitude)
            print(data.longitude)
        }
        
        apiManager.getWeather(latitude: 37.004842, longitude: -85.925876) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
            print(data.temp)
            print(data.highTemp)
            print(data.lowTemp)
            print(data.condition.icon)
        }
    }
    
    //this function will give the UI some default whenever we first load the app
    func setupDefaultUI() {
        locationLabel.text = ""
        iconLabel.text = "🚀"
        currentTempLabel.text = "Enter a location!"
        highTempLabel.text = "-"
        lowTempLabel.text = "-"
    }
    
    @IBAction func unwindToWeatherDisplay(segue: UIStoryboardSegue) { }
    
    

    
}

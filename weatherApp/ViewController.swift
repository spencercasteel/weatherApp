//
//  ViewController.swift
//  weatherApp
//
//  Created by Spencer Casteel on 10/24/18.
//  Copyright © 2018 Spencer Casteel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let apiKeys = APIKeys()
        
        let darkSkyURL = "https://api.darksky.net/forecast/"
        
        let darkSkyKey = apiKeys.darkSkyKey
        let latitude = "37.004843"
        let longitude = "-85.925876"
        
        let url = darkSkyURL + darkSkyKey + "/" + latitude + "," + longitude
        
        print(url)
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let googleBaseURL = "https://maps.googlepis.com/maps/api/geocode/json?address="
        let googleRequestURL = googleBaseURL + "Glasgow,+Kentucky" + apiKeys.googleKey
        let googleRequest = Alamofire.request(googleRequestURL)
        
        googleRequest.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


//
//  GeoCodingData.swift
//  weatherApp
//
//  Created by Spencer Casteel on 10/26/18.
//  Copyright © 2018 Spencer Casteel. All rights reserved.
//

import Foundation
import SwiftyJSON

class GeoCodingData {
    
    //MARK:- Types
    
    //keys that will be needed to get the correct info from the google Geocoding API
    enum GeocodingDataKeys: String {
        case results = "results"
        case formattedAddress = "formatted_address"
        case geometry = "geometry"
        case location = "location"
        case latitude = "lat"
        case longitude = "lng"
    }
    
    //Mark:- Properties
    
    var formattedAddress: String
    var latitude: Double
    var longitude: Double
    
    //MARK:- Methods
    
    //regular initializer
    init(formattedAddress: String, latitude: Double, longitude: Double) {
        self.formattedAddress = formattedAddress
        self.latitude = latitude
        self.longitude = longitude
    }
    
    //failable convenience initalizer for breaking down data from JSON and creating GeocodingData
    convenience init?(json: JSON) {
        guard let results = json[GeocodingDataKeys.results.rawValue].array else {
            return nil
        }
        
        guard let formattedAddress = results[0][GeocodingDataKeys.formattedAddress.rawValue].string else {
            return nil
        }
        
        guard let latitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.latitude.rawValue].double else {
            return nil
        }
        
        guard let longitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.longitude.rawValue].double else {
            return nil
        }
        
        self.init(formattedAddress: formattedAddress, latitude: latitude, longitude: longitude)
    }
}

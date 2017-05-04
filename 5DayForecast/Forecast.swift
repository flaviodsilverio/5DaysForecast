//
//  Forecast.swift
//  5DayForecast
//
//  Created by Flávio Silvério on 02/05/17.
//  Copyright © 2017 Flávio Silvério. All rights reserved.
//

import Foundation
/*
 {"dt":1485799200,
 "main":{"temp":261.45,"temp_min":259.086,"temp_max":261.45,
 "pressure":1023.48,
 "sea_level":1045.39,
 "grnd_level":1023.48,
 "humidity":79,
 "temp_kf":2.37},
 "weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"02n"}],
 "clouds":{"all":8},
 "wind":{"speed":4.77,"deg":232.505},
 "snow":{},
 "sys":{"pod":"n"},
 "dt_txt":"2017-01-30 18:00:00"}
 */
struct Forecast {
    
    var weatherDescription = ""
    var weatherType = ""
    var date = Date()

    var humidity : Int = 0
    var maxTemp : Float = 0
    var minTemp : Float = 0
    
    init(withForecast forecast: JSON) {
    
        guard let mainInfo = forecast["main"] as? JSON,
              let weatherInfo = (forecast["weather"] as? [JSON])?.first else { return }
                
        maxTemp = mainInfo["temp_max"] as! Float - 273.15
        minTemp = mainInfo["temp_min"] as! Float - 273.15
        humidity = mainInfo["humidity"] as! Int

        weatherDescription = weatherInfo["description"] as! String
        weatherType = weatherInfo["main"] as! String
        
        date = DateManager.sharedInstance.get(dateFromString: forecast["dt_txt"] as! String)!
        
    }

}

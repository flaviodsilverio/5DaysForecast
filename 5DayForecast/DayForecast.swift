//
//  DayForecast.swift
//  5DayForecast
//
//  Created by Flávio Silvério on 02/05/17.
//  Copyright © 2017 Flávio Silvério. All rights reserved.
//

import Foundation
//

struct DayForecast {

    var maxTemp : Float = -1000
    var minTemp : Float = 1000

    var forecasts = [Forecast]()
    
    var date : Date?
    
    var dayType : String?
    
    init(withData data: [JSON]) {
        
        var weatherTypes = [String:Int]()
        
        data.forEach({ element in
            
            let forecast = Forecast(withForecast: element)
            forecasts.append(forecast)
            
            if forecast.maxTemp > maxTemp {
                maxTemp = forecast.maxTemp
            }
            
            if forecast.minTemp < minTemp {
                minTemp = forecast.minTemp
            }
            
            if weatherTypes.keys.contains(forecast.weatherType) {
                weatherTypes[forecast.weatherType]! += 1
            } else {
                weatherTypes[forecast.weatherType] = 1
            }
            
        })
        
        var mostCommon = (count: 0,value: "")
        
        for (key, value) in weatherTypes {
            if value > mostCommon.count {
                mostCommon.count = value
                mostCommon.value = key
            }
        }
        
        dayType = mostCommon.value
        date = forecasts.last?.date

    }
    
    
}

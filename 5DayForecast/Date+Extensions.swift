//
//  Date+Extensions.swift
//  5DayForecast
//
//  Created by Flávio Silvério on 03/05/17.
//  Copyright © 2017 Flávio Silvério. All rights reserved.
//

import Foundation

extension Date {
    
    func dayOfTheWeek() -> String? {
        
        let formatter = DateManager.sharedInstance.dayFormatter
        
        let weekday = formatter.string(from: self).capitalized
        let todaysWeekDay =  formatter.string(from: Date()).capitalized
        
        if weekday == todaysWeekDay {
            return "Today"
        } else {
            return weekday
        }
    }
    
    func hour() -> String {
    
        let formatter = DateManager.sharedInstance.hourFormatter
        
        return formatter.string(from: self)
        
    }
    
}

//
//  File.swift
//  5DayForecast
//
//  Created by Flávio Silvério on 03/05/17.
//  Copyright © 2017 Flávio Silvério. All rights reserved.
//

import Foundation

final class DateManager {

    static let sharedInstance = DateManager()
    
    lazy var formatter : DateFormatter = DateFormatter()
    let calendar = NSCalendar(calendarIdentifier: .gregorian)!

    lazy var dayFormatter : DateFormatter = DateFormatter()
    
    lazy var hourFormatter : DateFormatter = DateFormatter()
    
    init() {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dayFormatter.dateFormat = "EEEE"
        hourFormatter.dateFormat = "HH:mm"
    }
    
    func get(dateFromString string: String) -> Date? {
       return formatter.date(from: string)
    }

}





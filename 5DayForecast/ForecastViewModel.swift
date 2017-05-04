//
//  ForecastViewModel.swift
//  5DayForecast
//
//  Created by Flávio Silvério on 02/05/17.
//  Copyright © 2017 Flávio Silvério. All rights reserved.
//

import Foundation

protocol ForecastViewModelDelegate: class {
    func updateView()
    func show(errorWith details: String)
}

class ForecastViewModel {

    weak var delegate : ForecastViewModelDelegate?
    
    var cityName = "London"
    var dayForecasts = [DayForecast]()

    let requestClient = RequestClient()

    func dayForecast(at index: Int) -> DayForecast? {
    
        guard index < dayForecasts.count else { return nil }
        
        return dayForecasts[index]
        
    }
    
    var numberOfDayForecasts : Int {
        return dayForecasts.count
    }
    
    func getData(){
        
        requestClient.get(dataFromEndpoint: "http://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=9ab980154b2797d68656609717cbb4e6") { (success, data, error) in
            
            if success {
                self.configure(data: data!)
            } else {
                DispatchQueue.main.sync {
                    self.delegate?.show(errorWith: error!)
                }
            }
            
        }

    }
    
    func configure(data: JSON){
        
        guard let list = data["list"] as? [JSON] else { return }
        
        var dataStructure : [String:[JSON]] = [:]
        
        list.forEach({ element in
            
            let day = (element["dt_txt"] as! String).components(separatedBy: " ").first
            
            if dataStructure.keys.contains(day!) {
                dataStructure[day!]?.append(element)
            } else {
                dataStructure[day!] = [element]
            }
            
        })
        
        for key in dataStructure.keys {
            dayForecasts.append(DayForecast(withData: dataStructure[key]!))
        }
        
        dayForecasts.sort(by: { (first: DayForecast, second: DayForecast) -> Bool in
            first.date! < second.date!
        })
        
        DispatchQueue.main.sync {
            self.delegate?.updateView()
        }
        
    }
    
}

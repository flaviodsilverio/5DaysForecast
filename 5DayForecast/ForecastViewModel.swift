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
    

    func dayForecast(at index: Int) -> DayForecast? {
    
        guard index < dayForecasts.count else { return nil }
        
        return dayForecasts[index]
        
    }
    
    var numberOfDayForecasts : Int {
        return dayForecasts.count
    }
    
    func getData(){
        
        let request = URLRequest(url: URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=9ab980154b2797d68656609717cbb4e6")!)
        let sessionConfiguration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfiguration)
        
        session.dataTask(with: request){
            [weak self] data, response, error in
            
            if error != nil {
                self?.delegate?.show(errorWith: (error!.localizedDescription))
            } else {
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    self?.delegate?.show(errorWith: "HTTPResponse Unreadable")
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! JSON
                        
                        self?.configure(data: json)
                        
                    } catch {
                        self?.delegate?.show(errorWith: "Response Unreadable")
                    }
                } else {
                    self?.delegate?.show(errorWith: String(describing: httpResponse.statusCode))
                }
            }
            
            }.resume()
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
            print(key)
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

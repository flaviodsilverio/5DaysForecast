//
//  HourForecastCell.swift
//  5DayForecast
//
//  Created by Flávio Silvério on 03/05/17.
//  Copyright © 2017 Flávio Silvério. All rights reserved.
//

import UIKit

final class HourForecastCell: UITableViewCell {

    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var weatherDetailsLabel: UILabel!
    @IBOutlet private weak var minTempLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!

    var forecast : Forecast? {
    
        didSet{
        
            guard let humidity = forecast?.humidity,
            let weatherDescription = forecast?.weatherDescription,
            let minTemp = forecast?.minTemp,
            let weatherType = forecast?.weatherType,
            let hour = forecast?.date.hour() else { return }
        
            minTempLabel.text = String(format: "%.0f", minTemp) //We could 
            humidityLabel.text = String(describing: humidity)
            weatherDetailsLabel.text = weatherDescription.capitalized
            hourLabel.text = hour
            weatherImageView.image = UIImage.image(forWeatherType: weatherType)
        
        }
        
    }
    
}

//
//  DayForecastCell.swift
//  5DayForecast
//
//  Created by Flávio Silvério on 03/05/17.
//  Copyright © 2017 Flávio Silvério. All rights reserved.
//

import UIKit

final class DayForecastCell: UITableViewCell {
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var minTempLabel: UILabel!
    @IBOutlet private weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var dayTypeImageView: UIImageView!
    var day : DayForecast? {
        
        didSet {
            
            guard let currentDay = day?.date?.dayOfTheWeek(),
                let minTemp = day?.minTemp,
                let maxTemp = day?.maxTemp,
                let dayType = day?.dayType else { return }
            
            dayLabel.text = currentDay
            minTempLabel.text = String(describing: Int(minTemp))
            maxTempLabel.text = String(describing: Int(maxTemp))
            dayTypeImageView.image = UIImage.image(forWeatherType: dayType)
            
        }
        
    }
}

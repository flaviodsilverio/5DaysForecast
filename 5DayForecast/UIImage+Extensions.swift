//
//  UIImage+Extensions.swift
//  5DayForecast
//
//  Created by Flávio Silvério on 04/05/17.
//  Copyright © 2017 Flávio Silvério. All rights reserved.
//

import UIKit

extension UIImage {

    class func image(forWeatherType type: String) -> UIImage {
    
        guard let image = UIImage(named: type) else { return UIImage() }
        
        return image

        }
    
}

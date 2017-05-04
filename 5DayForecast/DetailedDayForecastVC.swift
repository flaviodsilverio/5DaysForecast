//
//  DetailedDayForecastVC.swift
//  5DayForecast
//
//  Created by Flávio Silvério on 02/05/17.
//  Copyright © 2017 Flávio Silvério. All rights reserved.
//

import UIKit

class DetailedDayForecastVC: UITableViewController {

    var dayForecast : DayForecast!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "HourForecastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        self.title = dayForecast.date?.dayOfTheWeek()
    }


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayForecast.forecasts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HourForecastCell

        cell.forecast = dayForecast.forecasts[indexPath.row]
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

}

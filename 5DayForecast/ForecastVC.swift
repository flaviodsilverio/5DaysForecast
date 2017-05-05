//
//  ForecastVC.swift
//  5DayForecast
//
//  Created by Flávio Silvério on 02/05/17.
//  Copyright © 2017 Flávio Silvério. All rights reserved.
//

import UIKit

class ForecastVC: UIViewController, ForecastViewModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ForecastViewModel()
    var errorButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "DayForecastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        viewModel.delegate = self
        getData()
    }
    
    func getData(){
        viewModel.getData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! DetailedDayForecastVC
        destination.dayForecast = viewModel.dayForecast(at: (tableView.indexPathForSelectedRow?.row)!)
    }
}


//MARK: Table View DataSource
extension ForecastVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DayForecastCell
        
        cell.day = viewModel.dayForecast(at: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfDayForecasts
    }
}

//MARK: TableView Delegate
extension ForecastVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
}

//MARK: Forecast View Model Delegate
extension ForecastVC {

    func updateView() {
        
        self.title = viewModel.cityName
        
        self.errorButton?.removeFromSuperview()
        
        self.tableView.reloadData()
    }
    
    func show(errorWith details: String) {
        
        let alertController = UIAlertController(title: "Error", message: details, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: {
        
            self.errorButton = self.errorButton == nil ? UIButton(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: 50)) : self.errorButton
            self.errorButton?.backgroundColor = UIColor.red
            self.errorButton?.addTarget(self, action: #selector(self.getData), for: .touchUpInside)
            self.errorButton?.setTitle("Tap Here To Retry", for: .normal)
            self.view.addSubview(self.errorButton!)
            
        })
        
    }
}



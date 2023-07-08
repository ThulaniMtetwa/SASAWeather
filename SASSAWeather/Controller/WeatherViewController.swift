//
//  WeatherViewController.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var data: Weather?
    
    var weatherViewModel = WeatherViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
        // Do any additional setup after loading the view.
        setupView()
        weatherViewModel.fetchBreaches{ [weak self] breaches in
            
            //            switch breaches
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
    
    private func setupView() {
        // Configure Weather Data Container View
        tableView.isHidden = true
        
        // Configure Activity Indicator View
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }
    
    private lazy var dayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter
    }()
    
    func updateUI() {
        self.tableView.refreshControl?.endRefreshing()
        activityIndicatorView.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
        
    }
    
    @objc func callPullToRefresh(){
        weatherViewModel.fetchBreaches{ [weak self] breaches in
            
            //            switch breaches
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherViewModel.weather?.forecasts.count ?? 0
        //        tableView.setEmptyView(title: "You don't have any contact.", message: "Your contacts will be in here.", messageImage: UIImage(systemName: "sun.max")!)
        //        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.reuseIdentifier, for: indexPath) as? WeatherTableViewCell else {
            fatalError("Unable to Dequeue Weather Day Table View Cell")
        }
        let cellData = weatherViewModel.weather?.forecasts[indexPath.row]
        if let date = cellData?.date, compareDate(dateFromString(string: date)) {
            cell.dayLabel.text = "Today"
        } else {
            cell.dayLabel.text = dayFormatter.string(from: dateFromString(string: cellData?.date ?? ""))
        }
        cell.temperatureLabel.text = String(format: "%.0C°", cellData?.temp.toCelcius ?? 0.0)
        cell.windSpeedLabel.text = String(format: "%.f KPH", cellData?.windSpeed.toKPH ?? 0.0)
        return cell
    }
    
    func dateFromString(string: String) -> Date {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate] // Added format options
        let date = dateFormatter.date(from: string) ?? Date.now
        return date
    }
    
    func compareDate(_ date: Date) -> Bool {
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.autoupdatingCurrent
        let result = calendar.compare(date, to: Date.now, toGranularity: .weekday)
        return result == .orderedSame
    }
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        175
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        175
    }
}

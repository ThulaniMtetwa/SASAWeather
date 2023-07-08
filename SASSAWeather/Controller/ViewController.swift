//
//  ViewController.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/07.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    
    var data: Weather?
    
    var weatherViewModel = WeatherViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        
        
        weatherViewModel.fetchBreaches{ [weak self] breaches in
            
//            switch breaches
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
    
    func updateUI() {
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherViewModel.weather?.forecasts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellData = weatherViewModel.weather?.forecasts[indexPath.row]
        cell.textLabel?.text = cellData?.date
        cell.imageView?.image = cellData?.safe ?? false ? UIImage(systemName: "sun.max") : UIImage(systemName: "sun.max.trianglebadge.exclamationmark")
        
        return cell
    }
}

extension ViewController: UITableViewDelegate { }

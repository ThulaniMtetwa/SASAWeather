//
//  WeatherViewController.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var weatherViewModel = WeatherViewModel(repo: WeatherRepository(apiService: NetworkManager())) //This can be avoided with dependency containers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNetworkMonitoring()
        configureTableView()
        loadActivityIndicator()
        loadViewWithData()
    }
    
    private func loadViewWithData() {
        weatherViewModel.getWeatherForecast{ [weak self] forecast in
            
            switch forecast {
            case .success(_):
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.presentAlert(of: failure)
                }
            }
        }
    }
    
    private func presentAlert(of alertType: NetworkError) {
        switch alertType {
        case .failedRequest, .invalidResponse, .unexpectedStatusCode:
            self.tableView.setEmptyView(title: "Something unexpected happened.",
                                        message: "Please pull down to refresh to try again :)",
                                        messageImage: UIImage(systemName: "exclamationmark.triangle.fill")?.withTintColor(.red))
            break
        case .unknown, .invalidURL:
            
            let alertController = UIAlertController(title: "Important",
                                                    message: "We sincerely apologise for this. Contact ThulaniMtetwa@gmail.com for assistance :)",
                                                    preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true)
        }
    }
    
    private func registerNetworkMonitoring() {
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
    }
    
    private func configureTableView() {
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
    }
    
    private func loadActivityIndicator() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }
    
    private func updateUI() {
        self.tableView.refreshControl?.endRefreshing()
        activityIndicatorView.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    @objc func showOfflineDeviceUI(notification: Notification) {
        if NetworkMonitor.shared.isConnected {
            DispatchQueue.main.async {
                self.updateUI()
            }
        } else {
            DispatchQueue.main.async {
                self.showErrorView(title: "No Internet Connection",
                                   message: "Make sure you on a stable line. Please pull down to refresh to try again :)",
                                   messageImage: UIImage(systemName: "wifi.exclamationmark")?.withTintColor(.red))
            }
        }
    }
    
    
    private func showErrorView(title: String, message: String, messageImage: UIImage?) {
        self.tableView.setEmptyView(title: title,
                                    message: message,
                                    messageImage: messageImage)
    }
    
    deinit {
        NetworkMonitor.shared.stopMonitoring()
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func callPullToRefresh(){
        weatherViewModel.getWeatherForecast{ [weak self] data in
            
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let forecasts = weatherViewModel.weather?.forecasts else {
            self.tableView.setEmptyView(title: "No Data.",
                                        message: "Please pull down to refresh to try again :)",
                                        messageImage: UIImage(systemName: "exclamationmark.triangle.fill")?.withTintColor(.red))
            return 0
        }
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.reuseIdentifier, for: indexPath) as? WeatherTableViewCell else {
            fatalError("Unable to Dequeue \(String(describing: WeatherTableViewCell.self))")
        }
        
        cell.configureCell(with: weatherViewModel, at: indexPath)
        return cell
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

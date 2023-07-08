//
//  WeatherTableViewCell.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import UIKit

extension UITableViewCell: ReusableView {}

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configureCell(with model: WeatherViewModel, at indexPath: IndexPath) {
        let cellData = model.weather?.forecasts[indexPath.row]
        dayLabel.text = model.dayFormatter.string(from: model.dateFromString(string: cellData?.date ?? ""))
        temperatureLabel.text = String(format: "%.f C°", cellData?.temp.toCelcius ?? 0.0)
        windSpeedLabel.text = String(format: "%.f KPH", cellData?.windSpeed.toKPH ?? 0.0)
        conditionLabel.text = cellData?.safe ?? false ? "good" : "bad"
        iconImageView.image = cellData?.safe ?? false ? UIImage(systemName: "sun.max") : UIImage(systemName: "sun.max.trianglebadge.exclamationmark")
    }
}

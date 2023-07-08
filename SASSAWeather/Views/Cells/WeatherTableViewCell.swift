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

}

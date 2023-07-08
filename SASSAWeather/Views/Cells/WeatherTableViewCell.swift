//
//  WeatherTableViewCell.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import UIKit

protocol ReusableView {

    static var reuseIdentifier: String { get }

}

extension ReusableView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}

extension UITableViewCell: ReusableView {}

class WeatherTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()

        // Configure Cell
        selectionStyle = .none
    }

}

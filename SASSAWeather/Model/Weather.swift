//
//  Weather.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import Foundation

struct Weather: Codable {
    let forecasts: [Forecast]
    let lastUpdated, weatherStation: String
}

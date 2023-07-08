//
//  Forecast.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import Foundation

struct Forecast: Codable {
    let date: String
    let temp, humidity, windSpeed: Double
    let safe: Bool
}

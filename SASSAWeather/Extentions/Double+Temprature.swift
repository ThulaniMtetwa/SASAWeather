//
//  Double+Temprature.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//  Formula used is from https://www.almanac.com/temperature-conversion-celsius-fahrenheit

import Foundation

extension Double {
    var toCelcius: Double {
        (self - 32.0) / 1.8
    }

    var toKPH: Double {
        self * 1.609344
    }
    
    var toFahrenheit: Double {
        (self.toCelcius * 1.8) + 32
    }
}

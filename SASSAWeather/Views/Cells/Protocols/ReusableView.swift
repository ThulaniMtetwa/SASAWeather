//
//  ReusableView.swift
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

//
//  TestDataGenerator.swift
//  SASSAWeatherTests
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import Foundation
@testable import SASSAWeather

protocol TestDataGenerator: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T
}

extension TestDataGenerator {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }

        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(type, from: data)

            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
    }
}

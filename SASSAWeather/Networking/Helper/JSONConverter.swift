//
//  JSONConverter.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import Foundation

public struct JSONConverter {
    public static func decode<T: Codable>(_ data: Data) throws -> T? {
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw error
        }
    }
}

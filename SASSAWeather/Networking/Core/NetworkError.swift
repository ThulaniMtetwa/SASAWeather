//
//  NetworkError.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import Foundation

enum NetworkError: Error {
    case decode
    case invalidURL
    case noResponse
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        default:
            return "Unknown error. Please try again."
        }
    }
}

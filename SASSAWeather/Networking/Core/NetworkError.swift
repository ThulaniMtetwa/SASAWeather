//
//  NetworkError.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case unexpectedStatusCode
    case unknown
    case invalidResponse
    case failedRequest
    
    var customMessage: String {
        switch self {
        case .invalidResponse:
            return "Decode error"
        default:
            return "Unknown error. Please try again."
        }
    }
}

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
}

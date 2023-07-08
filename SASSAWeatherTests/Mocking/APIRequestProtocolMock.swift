//
//  APIRequestProtocolMock.swift
//  SASSAWeatherTests
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import Foundation
@testable import SASSAWeather

struct APIRequestProtocolMock: APIRequestProtocol {
    
    func getWeatherDetails(_ session: URLSession, using completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        
        completionHandler(.success(Data()))
    }
}

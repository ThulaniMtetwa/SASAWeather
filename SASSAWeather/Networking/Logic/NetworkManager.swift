//
//  NetworkManager.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/07.
//

import Foundation

protocol APIRequestProtocol {
    func getWeatherDetails(_ session: URLSession, using completionHandler: @escaping (Result<Data, NetworkError>) -> Void)
}

struct NetworkManager: APIRequestProtocol {
    
    func getWeatherDetails(_ session: URLSession, using completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        
        guard let url = URL(string: Constants.nasaURL) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
            if error != nil {
                completionHandler(.failure(.failedRequest))
            } else if let data = data, let response = response as? HTTPURLResponse,
                      200 ..< 300 ~= response.statusCode {
                completionHandler(.success(data))
            } else {
                completionHandler(.failure(.unexpectedStatusCode))
                return
            }
        }).resume()
    }
}

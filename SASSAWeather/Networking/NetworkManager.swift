//
//  NetworkManager.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/07.
//

import Foundation

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    typealias ServerResponse = (data: Data, response: URLResponse)
    
    private init() {}
    
    func getWeatherDetails(_ session: URLSession, using completionHandler: @escaping (Result<ServerResponse, Error>) -> Void) {
        
        guard let url = URL(string: Constants.nasaURL) else {
            completionHandler(.failure(NetworkError.invalidURL))
            return
        }
        
        session.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse,
                      200 ..< 300 ~= response.statusCode {
                completionHandler(.success((data, response)))
            } else {
                completionHandler(.failure(NetworkError.unexpectedStatusCode))
                return
            }
        }).resume()
    }
}

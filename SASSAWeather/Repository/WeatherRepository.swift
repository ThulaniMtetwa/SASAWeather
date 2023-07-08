//
//  WeatherRepository.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import Foundation

enum WeatherDataError: Error {
    case invalidResponse
    case failedRequest
    case unknown
}

class WeatherRepository {
    
    typealias WeatherDataResult = (Result<Weather?, WeatherDataError>) -> ()
    
    func fetchWeatherDetails(completion: @escaping (Result<Weather?, WeatherDataError>) -> Void) {
        
        NetworkManager.sharedInstance.getWeatherDetails(URLSession.shared, using: { result in
            
            switch result {
            case .success(let success):
                self.didFetchWeatherData(data: success, error: nil, completion: completion)
            case .failure(let failure):
                self.didFetchWeatherData(data: nil, error: failure, completion: completion)
            }
        })
        
    }
    
    private func didFetchWeatherData(data: Data?, error: Error?, completion: WeatherDataResult) {
        if let error = error {
            completion(.failure(.failedRequest))
            print("Unable to Fetch Weather Data, \(error)")

        } else if let data = data {
            
                do {
                    // Decode JSON
                    let result: Weather? = try JSONConverter.decode(data)

                    // Invoke Completion Handler
                    completion(.success(result))

                } catch {
                    completion(.failure(.invalidResponse))
                    print("Unable to Decode Response, \(error)")
                }

        } else {
            completion(.failure(.unknown))
        }
    }

}

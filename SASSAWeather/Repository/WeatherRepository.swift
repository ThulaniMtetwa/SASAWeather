//
//  WeatherRepository.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import Foundation

protocol WeatherRepositoryProtocol: AnyObject {
    func fetchWeatherDetails(completion: @escaping (Result<Weather?, NetworkError>) -> Void)
}

class WeatherRepository: WeatherRepositoryProtocol {
    
    typealias WeatherDataResult = (Result<Weather?, NetworkError>) -> ()
    
    private let apiService: APIRequestProtocol
    
    init(apiService: APIRequestProtocol) {
        self.apiService = apiService
    }
    
    func fetchWeatherDetails(completion: @escaping (Result<Weather?, NetworkError>) -> Void) {
        
        apiService.getWeatherDetails(URLSession.shared, using: { result in
            
            switch result {
            case .success(let success):
                self.didFetchWeatherData(data: success, error: nil, completion: completion)
            case .failure(let failure):
                self.didFetchWeatherData(data: nil, error: failure, completion: completion)
            }
        })
        
    }
    
    private func didFetchWeatherData(data: Data?, error: Error?, completion: WeatherDataResult) {
        guard error != nil else {
            completion(.failure(.failedRequest))
            return
        }
        
        if let data = data {
            do {
                let result: Weather? = try JSONConverter.decode(data)
                completion(.success(result))
                
            } catch {
                completion(.failure(.invalidResponse))
            }
        } else {
            completion(.failure(.unknown))
        }
    }
}

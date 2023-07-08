//
//  WeatherViewModel.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import Foundation

class WeatherViewModel {
    var weather: Weather?
    
    private let repo: WeatherRepositoryProtocol
    
    init(model: Weather? = nil, repo: WeatherRepositoryProtocol) {
        self.repo = repo
        if let inputModel = model {
            self.weather = inputModel
        }
    }
}

extension WeatherViewModel {
    func getWeatherForecast(completion: @escaping (Result<Weather?, NetworkError>) -> Void) {
        repo.fetchWeatherDetails(completion: { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                self.weather = success
                completion(.success(success))
            case .failure(_): break
            }
        })
        
    }
}

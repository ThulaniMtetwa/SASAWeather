//
//  WeatherViewModel.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import Foundation

class WeatherViewModel {
    var weather: Weather?
    
    init(model: Weather? = nil) {
        if let inputModel = model {
            self.weather = inputModel
        }
    }
}

extension WeatherViewModel {
    func fetchBreaches(completion: @escaping (Result<Weather?, Error>) -> Void) {
        
        let repo = WeatherRepository()
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

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
    func fetchBreaches(completion: @escaping (Result<Weather, Error>) -> Void) {
        
        NetworkManager.sharedInstance.getWeatherDetails(URLSession.shared, using: { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                let decoder = JSONDecoder()
                do
                {
                    self.weather = try decoder.decode(Weather.self, from: success.data)
                    completion(.success(try decoder.decode(Weather.self, from: success.data)))
                } catch {
                    // deal with error from JSON decoding if used in production
                }
            case .failure(let failure):
                print ("failure", failure)
            }
        })
        
    }
}

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
    
    public lazy var dayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()
    
    public lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter
    }()
    
    init(model: Weather? = nil, repo: WeatherRepositoryProtocol) {
        self.repo = repo
        if let inputModel = model {
            self.weather = inputModel
        }
    }
    
    func dateFromString(string: String) -> Date {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate]
        let date = dateFormatter.date(from: string) ?? Date.now
        return date
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

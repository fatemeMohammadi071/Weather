//
//  WeatherService.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import Foundation

protocol WeatherService {
    func getWeatherList(woeid: WOEIDCities, date: String, completion: @escaping (Result<Weather?, Error>) -> Void)
    func fetchWeatherIcon(weatherStateAbbr: String?, completion: @escaping (Result<Data?, Error>) -> Void)
}

final class DefaultWeatherService {
    
    private let networkManager: NetworkManagerProtocol
    private let configuration : AppConfiguration

    init(configuration : AppConfiguration, networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.configuration = configuration
    }
}

extension DefaultWeatherService: WeatherService {
    func getWeatherList(woeid: WOEIDCities, date: String, completion: @escaping (Result<Weather?, Error>) -> Void) {
        _ = networkManager.request(WeatherEndPoint.getWeatherInfo(configuration: configuration, woeid: woeid.rawValue, date: date)) { (result) in
            switch result {
            case .success(let data):
                let interactor = Interactor<Weathers>()
                guard let data = data, let model = interactor.parse(data: data) else { return }
                completion(.success(model[safe: 0]))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchWeatherIcon(weatherStateAbbr: String?, completion: @escaping (Result<Data?, Error>) -> Void) {
        _ = networkManager.request(WeatherEndPoint.getWeatherIcon(configuration: configuration, weatherStateAbbr: weatherStateAbbr), completion: { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}


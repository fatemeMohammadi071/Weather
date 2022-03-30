//
//  WeatherDetailDependencyContainer.swift
//  Weather
//
//  Created by Fateme on 1/9/1401 AP.
//

import UIKit

final class WeatherDetailDependencyContainer: DependencyContainer {
    var weather: Weather?
}

extension WeatherDetailDependencyContainer: WeatherDetailFactory {
    
    func makeWeatherDetailViewController(weatherDetail: Weather) -> WeatherDetailViewController {
        self.weather = weatherDetail
        return WeatherDetailViewController(factory: self)
    }
    
    func makeWeatherDetailViewModel(weatherDetail: Weather?) -> WeatherDetailViewModel {
        return DefaultWeatherDetailViewModel(weather: weatherDetail)
    }
}

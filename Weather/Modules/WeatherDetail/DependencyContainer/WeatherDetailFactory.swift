//
//  WeatherDetailFactory.swift
//  Weather
//
//  Created by Fateme on 1/9/1401 AP.
//

import UIKit

typealias WeatherDetailFactory = WeatherDetailViewControllerFactory & WeatherDetailViewModelFactory

protocol WeatherDetailViewControllerFactory {
    var weather: Weather? { get }
    func makeWeatherDetailViewController(weatherDetail: Weather) -> WeatherDetailViewController
}

protocol WeatherDetailViewModelFactory {
    func makeWeatherDetailViewModel(weatherDetail: Weather?) -> WeatherDetailViewModel
}

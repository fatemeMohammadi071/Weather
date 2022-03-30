//
//  WeatherFactory.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import UIKit

typealias WeatherFactory = WeatherViewControllerFactory & WeatherServiceFactory & WeatherViewModelFactory & WeatherFlowCoordinatorFactory

protocol WeatherViewControllerFactory {
    var action: WeatherListViewModelAction? { get }
    func makeWeatherViewController(action: WeatherListViewModelAction) -> WeatherListViewController
}

protocol WeatherServiceFactory {
    func makeWeatherService() -> WeatherService
}

protocol WeatherViewModelFactory {
    func makeWeatherViewModel(action: WeatherListViewModelAction?) -> WeatherListViewModel
}

protocol WeatherFlowCoordinatorFactory {
    func makeFlowCoordinator(navigationController: UINavigationController) -> WeatherFlowCoordinator
}

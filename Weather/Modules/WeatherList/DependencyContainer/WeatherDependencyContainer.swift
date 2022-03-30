//
//  WeatherDependencyContainer.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import UIKit

final class WeatherDependencyContainer: DependencyContainer {
    var action: WeatherListViewModelAction?
}

extension WeatherDependencyContainer: WeatherFactory {
    
    func makeWeatherViewController(action: WeatherListViewModelAction) -> WeatherListViewController {
        self.action = action
        return WeatherListViewController(factory: self)
    }
    
    func makeWeatherService() -> WeatherService {
        return DefaultWeatherService(configuration : configuration, networkManager: networkManager)
    }
    
    func makeWeatherViewModel(action: WeatherListViewModelAction?) -> WeatherListViewModel {
        return DefaultWeatherListViewModel(service: makeWeatherService(), action: action)
    }
    
    func makeFlowCoordinator(navigationController: UINavigationController) -> WeatherFlowCoordinator {
        return WeatherFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

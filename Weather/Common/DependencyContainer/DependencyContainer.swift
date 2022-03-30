//
//  DependencyContainer.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import Foundation

public class DependencyContainer {
    lazy var networkManager: NetworkManagerProtocol = NetworkManager()
    lazy var configuration: AppConfiguration = AppConfiguration()
}

extension DependencyContainer: WeatherFlowCoordinatorDependencies {
    func makeWeatherDependencyContainer() -> WeatherDependencyContainer {
        return WeatherDependencyContainer()
    }
    
    func makeWeatherDetailDependency() -> WeatherDetailDependencyContainer {
        return WeatherDetailDependencyContainer()
    }
}

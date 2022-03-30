//
//  WeatherFlowCoordinator.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import UIKit

protocol WeatherFlowCoordinatorDependencies  {
    func makeWeatherDependencyContainer() -> WeatherDependencyContainer
    func makeWeatherDetailDependency() -> WeatherDetailDependencyContainer
}

final class WeatherFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: WeatherFlowCoordinatorDependencies

    private weak var metaWeatherListVC: WeatherListViewController?

    init(navigationController: UINavigationController,
         dependencies: WeatherFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let action = WeatherListViewModelAction(showDetails: showDetails)
        let weatherDependency = dependencies.makeWeatherDependencyContainer()
        let vc = weatherDependency.makeWeatherViewController(action: action)
        navigationController?.pushViewController(vc, animated: false)
        metaWeatherListVC = vc
    }

    private func showDetails(weather: Weather) {
        let weatherDetailDependency = dependencies.makeWeatherDetailDependency()
        let vc = weatherDetailDependency.makeWeatherDetailViewController(weatherDetail: weather)
        navigationController?.pushViewController(vc, animated: false)
    }
}

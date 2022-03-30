//
//  AppFlowCoordinator.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: DependencyContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: DependencyContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let weatherDependencyContainer = appDIContainer.makeWeatherDependencyContainer()
        let flow = weatherDependencyContainer.makeFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}

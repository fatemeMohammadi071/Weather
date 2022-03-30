# Weather

## Requirements
- iOS 13.0+
- Xcode 13.2

## Architecture
### MVVM + Clean Architechure
This project has been developed using MVVM + clean architecture. trying to develop testable and readable. In this architecture we have fellow parts:

- Presentation: Including view and ViewModel
- Network: Infrastructure that is responsible for API calls
- FlowCoordinator: To route between different parts of the project
- Dependency Injection Container: to inject dependencies into the modules. It contains Factory that is an initializer injection for viewControllers which sends services in network layer to the viewModel

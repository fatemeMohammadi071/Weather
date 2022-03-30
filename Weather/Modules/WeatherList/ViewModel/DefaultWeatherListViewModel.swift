//
//  DefaultWeatherListViewModel.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import Foundation

struct WeatherListViewModelAction {
    let showDetails: (Weather) -> Void
}

protocol WeatherListViewModelInput {
    func viewDidLoad()
    func didSelectItem(at index: Int)
}

protocol WeatherListViewModelOutput {
    var items: Observable<Weathers> { get }
    var isLoading: Observable<Bool> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var errorTitle: String { get }
}

protocol WeatherListViewModel: WeatherListViewModelOutput, WeatherListViewModelInput {}

final class DefaultWeatherListViewModel: WeatherListViewModel {

    private let service: WeatherService
    private var weathers: Weathers = []
    private let dispatchQueue = DispatchQueue(label: "myQueue", qos: .background)
    private let dispatchGroup = DispatchGroup()
    private let action: WeatherListViewModelAction?
    
    let items: Observable<Weathers> = Observable([])
    let isLoading: Observable<Bool> = Observable(true)
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Weather", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    
    init(service: WeatherService, action: WeatherListViewModelAction? = nil) {
        self.service = service
        self.action = action
    }
}

private extension DefaultWeatherListViewModel {
    func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
        NSLocalizedString("No internet connection", comment: "") :
        NSLocalizedString("Failed loading weather", comment: "")
    }
    
    private func fetch(woeid: WOEIDCities, date: String) {
        dispatchQueue.async { [weak self] in
            guard let `self` = self else { return }
            self.service.getWeatherList(woeid: woeid, date: date) { [weak self] result in
                guard let `self` = self else { return }
                switch result {
                case .success(let weather):
                    guard var weather = weather else { return }
                    weather.city = woeid.title
                    self.weathers.append(weather)
                case .failure(let error):
                    self.handle(error: error)
                }
                self.dispatchGroup.leave()
            }
        }
    }
}

extension DefaultWeatherListViewModel: WeatherListViewModelInput {
    func viewDidLoad() {
        let tomorrowDate = Date().dayAfter.dateToString()
        
        self.isLoading.value = true
        WOEIDCities.allCases.forEach { woeid in
            dispatchGroup.enter()
            fetch(woeid: woeid, date: tomorrowDate)
        }
        
        dispatchGroup.notify(queue: .main) { 
            self.items.value = self.weathers
            self.isLoading.value = false
        }
    }
    
    func  didSelectItem(at index: Int) {
        action?.showDetails(weathers[index])
    }
    
}

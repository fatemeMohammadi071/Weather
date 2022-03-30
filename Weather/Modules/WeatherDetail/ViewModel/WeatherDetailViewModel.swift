//
//  WeatherDetailViewModel.swift
//  Weather
//
//  Created by Fateme on 1/9/1401 AP.
//

import Foundation

protocol WeatherDetailViewModelInput {
    func viewDidLoad()
}

protocol WeatherDetailViewModelOutput {
    var item: Observable<Weather?> { get }
    var screenTitle: String { get }
}

protocol WeatherDetailViewModel: WeatherDetailViewModelInput, WeatherDetailViewModelOutput {}

final class DefaultWeatherDetailViewModel: WeatherDetailViewModel {

    private var weather: Weather?
    
    let item: Observable<Weather?> = Observable(nil)
    let screenTitle = NSLocalizedString("Weather Detail", comment: "")
    
    init(weather: Weather?) {
        self.weather = weather
    }
}

extension DefaultWeatherDetailViewModel: WeatherDetailViewModelInput {
    func viewDidLoad() {
        guard let weather = self.weather else { return }
        self.item.value = weather
    }
    
}

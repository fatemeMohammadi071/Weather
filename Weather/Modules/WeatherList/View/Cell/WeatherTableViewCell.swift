//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Fateme on 1/8/1401 AP.
//

import UIKit

final class WeatherTableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var weatherIconImage: UIImageView!

    private var weatherService: WeatherService?
    private var weather: Weather?
    
    func fill(with weather: Weather, weatherService: WeatherService) {

        titleLabel.text = weather.city
        self.weatherService = weatherService
        self.weather = weather
        self.updateWeatherIcon()
    }
    
    private func updateWeatherIcon() {
        _ = weatherService?.fetchWeatherIcon(weatherStateAbbr: weather?.weatherStateAbbr, completion: { [weak self] result in
            guard let `self` = self else { return }
            if case let .success(data) = result {
                DispatchQueue.main.async {
                    guard let data = data, let image = UIImage(data: data) else { return }
                    self.weatherIconImage.image = image
                }
            }
        })
    }
}

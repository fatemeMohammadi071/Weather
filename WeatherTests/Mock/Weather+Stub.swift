//
//  Weather+Stub.swift
//  WeatherTests
//
//  Created by Fateme on 1/9/1401 AP.
//

import Foundation

@testable import Weather

extension Weather {
    static func stub(id: Int,
                     city: WOEIDCities? = WOEIDCities.gothenburg,
                     weatherStateName: String? = "Showers",
                     weatherStateAbbr: String? = "s",
                     windDirectionCompass: String? = "SW",
                     created: String? = "2020-04-27T22:39:31.918012Z",
                     applicableDate: String? = "2020-04-27",
                     minTemp: Double? = 5.275,
                     maxTemp: Double? = 7.040,
                     theTemp: Double? = 5.86,
                     windSpeed: Double? = 3.544,
                     windDirection: Double? = 233.0,
                     airPressure: Double? = 1004,
                     humidity: Int? = 89,
                     visibility: Double? = 9.51,
                     predictability: Int? = 73) -> Self {
        Weather(id: id, city: city?.rawValue, weatherStateName: weatherStateName, weatherStateAbbr: weatherStateAbbr, windDirectionCompass: windDirectionCompass, created: created, applicableDate: applicableDate,  minTemp: minTemp, maxTemp: maxTemp, theTemp: theTemp, windSpeed: windSpeed, windDirection: windDirection, airPressure: airPressure, humidity: humidity, visibility: visibility, predictability: predictability)
    }
}

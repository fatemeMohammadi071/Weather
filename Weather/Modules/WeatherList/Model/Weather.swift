//
//  Weather.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import Foundation

struct Weather: Codable {
    let id: Int
    var city: String?
    let weatherStateName, weatherStateAbbr, windDirectionCompass, created: String?
    let applicableDate: String?
    let minTemp, maxTemp, theTemp, windSpeed: Double?
    let windDirection, airPressure: Double?
    let humidity: Int?
    let visibility: Double?
    let predictability: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case windDirectionCompass = "wind_direction_compass"
        case created
        case applicableDate = "applicable_date"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case theTemp = "the_temp"
        case windSpeed = "wind_speed"
        case windDirection = "wind_direction"
        case airPressure = "air_pressure"
        case humidity, visibility, predictability
    }
}

typealias Weathers = [Weather]

enum WOEIDCities: String, Codable, CaseIterable {
    case gothenburg = "890869"
    case stockholm = "906057"
    case mountainView = "2455920"
    case london = "44418"
    case newYork = "2459115"
    case berlin = "638242"
    
    var title: String {
        switch self {
        case .gothenburg:
            return "Gothenburg"
        case .stockholm:
            return "Stockholm"
        case .mountainView:
            return "Mountain View"
        case .london:
            return "London"
        case .newYork:
            return "New York"
        case .berlin:
            return "Berlin"
        }
    }
}

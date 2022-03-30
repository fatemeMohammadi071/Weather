//
//  WeatherEndPoint.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import Foundation

enum WeatherEndPoint {
    case getWeatherInfo(configuration: AppConfiguration, woeid: String, date: String)
    case getWeatherIcon(configuration: AppConfiguration, weatherStateAbbr: String?)
}

extension WeatherEndPoint: RequestProtocol {
    var baseURL: String {
        switch self {
        case .getWeatherInfo(let configuration, _, _):
            return configuration.apiBaseURL
        case .getWeatherIcon(let configuration, _):
            return configuration.imagesBaseURL
        }
    }
    
    public var relativePath: String {
        switch self {
        case .getWeatherInfo(_, let woeid, let date):
            return "\(woeid)/\(date)/"
        case .getWeatherIcon(_, let weatherStateAbbr):
            return "png/\(weatherStateAbbr ?? "s").png"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getWeatherInfo, .getWeatherIcon: return .get
        }
    }
    
    public var requestType: RequestType {
        switch self {
        case .getWeatherInfo, .getWeatherIcon:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var authorizationType: AuthType {
        return .bearer
    }
}

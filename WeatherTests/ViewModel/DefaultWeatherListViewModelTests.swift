//
//  DefaultWeatherListViewModelTests.swift
//  WeatherTests
//
//  Created by Fateme on 1/9/1401 AP.
//

import XCTest
@testable import Weather

class DefaultWeatherListViewModelTests: XCTestCase {

    let weather: Weather = Weather.stub(id: 0)
    
    class WeatherServiceMock: WeatherService {
        var expectation: XCTestExpectation?
        var error: Error?
        var weather: Weather?
        
        func getWeatherList(woeid: WOEIDCities, date: String, completion: @escaping (Result<Weather?, Error>) -> Void) {
                if let error = self.error {
                    completion(.failure(error))
                } else {
                    completion(.success(self.weather))
                }
                self.expectation?.fulfill()
        }
        
        func fetchWeatherIcon(weatherStateAbbr: String?, completion: @escaping (Result<Data?, Error>) -> Void) {}
    }

    func test_whenGetWeatherListFailed_thenViewModelHasError() {
        // given
        let weatherService = WeatherServiceMock()
        weatherService.expectation = self.expectation(description: "contains error")
        weatherService.weather = nil
        weatherService.error = NetworkError.notConnected
        let viewModel = DefaultWeatherListViewModel(service: weatherService)
        
        // when
        viewModel.viewDidLoad()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(viewModel.error.value.isEmpty)
    }
}

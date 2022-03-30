//
//  NetworkSessionManagerMock.swift
//  WeatherTests
//
//  Created by Fateme on 1/8/1401 AP.
//

import Foundation

struct NetworkSessionManagerMock: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable {
        completion(data, response, error)
        return URLSessionTask()
    }
}

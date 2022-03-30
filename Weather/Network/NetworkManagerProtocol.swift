//
//  NetworkManagerProtocol.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import Foundation

protocol NetworkManagerProtocol {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    func request<Request: RequestProtocol>(_ request: Request,
                                           completion: @escaping CompletionHandler) -> NetworkCancellable?
}

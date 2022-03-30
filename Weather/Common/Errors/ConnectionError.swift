//
//  ConnectionError.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import Foundation

public protocol ConnectionError: Error {
    var isInternetConnectionError: Bool { get }
}

public extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? NetworkError, case .notConnected = error else {
            return false
        }
        return true
    }
}

//
//  NetworkManager.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

//import Foundation
//
//public enum NetworkError: Error {
//    case error(statusCode: Int, data: Data?)
//    case notConnected
//    case cancelled
//    case generic(Error)
//    case urlGeneration
//}
//
//public protocol NetworkCancellable {
//    func cancel()
//}
//
//public final class NetworkManager {
//    
//    private let sessionManager: NetworkSessionManager
//    
//    public init(sessionManager: NetworkSessionManager = DefaultNetworkSessionManager()) {
//        self.sessionManager = sessionManager
//    }
//    
//    private func request(request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {
//        let sessionDataTask = sessionManager.request(request) { data, response, requestError in
//            
//            if let requestError = requestError {
//                var error: NetworkError
//                if let response = response as? HTTPURLResponse {
//                    error = .error(statusCode: response.statusCode, data: data)
//                } else {
//                    error = self.resolve(error: requestError)
//                }
//                
//                completion(.failure(error))
//            } else {
//                completion(.success(data))
//            }
//        }
//        return sessionDataTask
//    }
//    
//    private func resolve(error: Error) -> NetworkError {
//        let code = URLError.Code(rawValue: (error as NSError).code)
//        switch code {
//        case .notConnectedToInternet: return .notConnected
//        case .cancelled: return .cancelled
//        default: return .generic(error)
//        }
//    }
//}
//
//extension NetworkManager: NetworkManagerProtocol {
//    func request<Request>(_ request: Request, completion: @escaping CompletionHandler) -> NetworkCancellable? where Request : RequestProtocol {
//        guard let url = URL(string: request.baseURL + request.relativePath) else {
//            completion(.failure(.urlGeneration))
//            return nil
//        }
//        let request = URLRequest(url: url)
//        return self.request(request: request, completion: completion)
//    }
//}

//
//  RequestProtocol.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
}

public enum AuthType {
    case none
    case basic
    case bearer
    case custom(String)

    public var value: String? {
        switch self {
        case .none: return nil
        case .basic: return "Basic"
        case .bearer: return "Bearer"
        case .custom(let customValue): return customValue
        }
    }
}

public struct FormData {

    public enum FormDataProvider {
        case data(Foundation.Data)
        case file(URL)
        case stream(InputStream, UInt64)
    }

    public init(provider: FormDataProvider, name: String, fileName: String? = nil, mimeType: String? = nil) {
        self.provider = provider
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }

    public let provider: FormDataProvider
    public let name: String
    public let fileName: String?
    public let mimeType: String?

}

public enum RequestType {
    case requestPlain
    case requestJSONEncodable(Encodable)
    case requestParameters(urlParameters: [String: Any])
    case uploadCompositeMultipart([FormData], urlParameters: [String: Any]?)
    case uploadFile(URL)
}

protocol RequestProtocol {
    var baseURL: String {get}
    var relativePath: String {get}
    var method: HTTPMethod {get}
    var headers: [String: String]? {get}
    var authorizationType: AuthType {get}
    var requestType: RequestType {get}
}

extension RequestProtocol {
    
    var authorizationType: AuthType {
        return .bearer
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
}

struct ExtraQueryParam {
    let name: String?
}

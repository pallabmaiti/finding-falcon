//
//  API.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 04/03/24.
//

import Foundation

enum API {
    case getPlanets
    case getVehicles
    case retrieveToken
    case findFalcon(FoundFalcon.Find.Request)
}

extension API {
    var baseURL: String {
        return "https://findfalcone.geektrust.com"
    }
    
    var path: String {
        switch self {
        case .getPlanets:
            return "/planets"
        case .getVehicles:
            return "/vehicles"
        case .retrieveToken:
            return "/token"
        case .findFalcon:
            return "/find"
        }
    }
    
    var httpMethod: String {
        var method: HTTPMethod
        switch self {
        case .getPlanets, .getVehicles:
            method = .GET
        case .retrieveToken, .findFalcon:
            method = .POST
        }
        return method.rawValue
    }
    
    var url: URL? {
        if let urlString = [baseURL, path].joined().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url = URL(string: urlString) {
            return url
        }
        return nil
    }
    
    var httpBody: Data? {
        if case .findFalcon(let request) = self {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(request)
        }
        return nil
    }
    
    var allHTTPHeaderFields: [String: String]? {
        switch self {
        case .retrieveToken, .findFalcon:
            return ["Accept": "application/json"]
        default:
            return nil
        }
    }
}

enum HTTPMethod: String {
    case GET
    case POST
}

//
//  APIClient.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 04/03/24.
//

import Foundation

protocol APIClient {
    func send(api: API) async throws -> APIResult
}

let sharedSession: URLSession = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 30
    configuration.timeoutIntervalForResource = 30
    return URLSession(configuration: configuration)
}()

final class URLSessionClient: APIClient {
    let session: URLSession
    
    init(session: URLSession = sharedSession) {
        self.session = session
    }
    
    func send(api: API) async throws -> APIResult {
        guard let urlRequest = api.urlRequest else {
            throw APIError.badURLRequest
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        return try Self.apiClientResult(for: (data, response))
    }
    
    private static func apiClientResult(for urlSessionTaskCompletion: (Data, URLResponse)) throws -> APIResult {
        let (data, response) = urlSessionTaskCompletion
        
        if let httpResponse = response as? HTTPURLResponse {
            let status = Status(statusCode: httpResponse.statusCode)
            return APIResult(status: status, data: data, error: nil)
        }
        
        throw APIError.noResponse
    }
}

extension API {
    var urlRequest: URLRequest? {
        guard let url = url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = httpBody
        request.allHTTPHeaderFields = allHTTPHeaderFields
        return request
    }
}

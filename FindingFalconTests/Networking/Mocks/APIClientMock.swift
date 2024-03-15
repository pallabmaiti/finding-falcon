//
//  APIClientMock.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 13/03/24.
//

import Foundation
@testable import FindingFalcon

class APIClientMock: APIClient {
    let result: (URLRequest) -> Result<HTTPURLResponse, Error>
    let data: Data?
    
    init(result: @escaping ((URLRequest) -> Result<HTTPURLResponse, Error>) = { _  in .success(.mockResponseWith(statusCode: 200))}, data: Data? = nil) {
        self.result = result
        self.data = data
    }
    
    convenience init(response: HTTPURLResponse, data: Data? = nil) {
        self.init(result: { _ in .success(response) }, data: data)
    }
    
    convenience init(error: Error, data: Data? = nil) {
        self.init(result: { _ in .failure(error) }, data: data)
    }
    
    func send(api: API) async throws -> APIResult {
        if let request = api.urlRequest {
            switch self.result(request) {
            case .success(let response):
                return APIResult(status: Status(statusCode: response.statusCode), data: data, error: nil)
            case .failure(let error):
                throw error
            }
        } else {
            throw APIError.badURLRequest
        }
    }
}

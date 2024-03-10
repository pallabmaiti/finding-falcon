//
//  ResponseHandler.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 04/03/24.
//

import Foundation

protocol ResponseHandlerProtocol {
    func parseData<T: Codable>(_ data: Data?) throws -> T?
}

final class ResponseHandler: ResponseHandlerProtocol {
    func parseData<T: Codable>(_ data: Data?) throws -> T? {
        guard let data = data else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}

//
//  ResponseHandler.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 04/03/24.
//

import Foundation

protocol ResponseHandlerProtocol {
    func parseData<T: Codable>(_ data: Data?) throws -> T?
}

let sharedDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

final class ResponseHandler: ResponseHandlerProtocol {
    let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = sharedDecoder) {
        self.decoder = decoder
    }
    
    func parseData<T: Codable>(_ data: Data?) throws -> T? {
        guard let data = data else {
            return nil
        }
        return try decoder.decode(T.self, from: data)
    }
}

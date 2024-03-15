//
//  APIError.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 04/03/24.
//

import Foundation

enum APIError: Error {
    case badURLRequest
    case noResponse
    case noData(result: APIResult)
}

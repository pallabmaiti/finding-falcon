//
//  APIResponse.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 04/03/24.
//

import Foundation

struct APIResult {
    let status: Status
    let data: Data?
    let error: Error?
}

enum Status {
    case success
    case failure
    case unknown
    case unauthorized
    
    init(statusCode: Int) {
        switch statusCode {
        case 200..<300:
            self = .success
        case 400:
            self = .unauthorized
        case 500..<600:
            self = .failure
        default:
            self = .unknown
        }
    }
    
    var needsRetry: Bool {
        return self == .unauthorized
    }
}

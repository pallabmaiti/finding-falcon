//
//  TokenWorker.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 05/03/24.
//

import Foundation

protocol TokenLogic {
    func retrieveToken() async throws -> SelectDestinations.RetrieveToken.Response
}

final class TokenWorker: TokenLogic {
    let networkManager: ServiceType
    
    init(networkManager: ServiceType) {
        self.networkManager = networkManager
    }
    
    func retrieveToken() async throws -> SelectDestinations.RetrieveToken.Response {
        return try await networkManager.retrieveToken().value
    }
}

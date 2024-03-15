//
//  FindFalconTokenWorker.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 05/03/24.
//

import Foundation

protocol FindFalconTokenLogic {
    func retrieveToken() async throws -> FindingFalcon.RetrieveToken.Response
}

final class FindFalconTokenWorker: FindFalconTokenLogic {
    let networkManager: ServiceType
    
    init(networkManager: ServiceType) {
        self.networkManager = networkManager
    }
    
    func retrieveToken() async throws -> FindingFalcon.RetrieveToken.Response {
        return try await networkManager.retrieveToken().value
    }
}

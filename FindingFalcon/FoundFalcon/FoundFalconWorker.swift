//
//  FindFalconWorker.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 05/03/24.
//

import Foundation

protocol FoundFalconLogic {
    func findFalcon(_ request: FoundFalcon.Find.Request) async throws -> FoundFalcon.Find.Response
}

final class FoundFalconWorker: FoundFalconLogic {
    let networkManager: ServiceType
    
    init(networkManager: ServiceType) {
        self.networkManager = networkManager
    }
    
    func findFalcon(_ request: FoundFalcon.Find.Request) async throws -> FoundFalcon.Find.Response {
        do {
            let response = try await networkManager.findFalcon(request)
            return response.value
        } catch {
            if let error: APIError = error as? APIError, case .noData(let result) = error, result.status.needsRetry {
                let response = try await networkManager.retrieveToken()
                return try await findFalcon(FoundFalcon.Find.Request(token: response.value.token, planetNames: request.planetNames, vehicleNames: request.vehicleNames))
            } else {
                throw error
            }
        }
    }
}

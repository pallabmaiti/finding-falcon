//
//  FindFalconWorker.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 05/03/24.
//

import Foundation

protocol FindFalconeLogic {
    func findFalcone(_ request: FindFalcone.Find.Request) async throws -> FindFalcone.Find.Response
}

final class FindFalconeWorker: FindFalconeLogic {
    let networkManager: ServiceType
    
    init(networkManager: ServiceType) {
        self.networkManager = networkManager
    }
    
    func findFalcone(_ request: FindFalcone.Find.Request) async throws -> FindFalcone.Find.Response {
        do {
            let response = try await networkManager.findFalcone(request)
            return response.value
        } catch {
            if let error: APIError = error as? APIError, case .noData(let result) = error, result.status.needsRetry {
                let response = try await networkManager.retrieveToken()
                return try await findFalcone(FindFalcone.Find.Request(token: response.value.token, planetNames: request.planetNames, vehicleNames: request.vehicleNames))
            } else {
                throw error
            }
        }
    }
}

//
//  NetworkManager.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 04/03/24.
//

import Foundation

typealias Handler<T> = (Result<T, Error>) -> Void

protocol ServiceType {
    func findFalcone(_ request: FindFalcone.Find.Request) async throws -> APIResponse<FindFalcone.Find.Response>
    func retrieveToken() async throws -> APIResponse<SelectDestinations.RetrieveToken.Response>
    func getVehicles() async throws -> APIResponse<[SelectDestinations.LoadVehicles.Response]>
    func getPlanets() async throws -> APIResponse<[SelectDestinations.LoadPlanets.Response]>
}

final class NetworkManager {
    let apiClient: APIClient
    let responseHandler: ResponseHandlerProtocol
    
    init(apiClient: APIClient, responseHandler: ResponseHandlerProtocol) {
        self.apiClient = apiClient
        self.responseHandler = responseHandler
    }
    
    private func send<T>(api: API) async throws -> APIResponse<T> {
        let result = try await apiClient.send(api: api)
        return try await self.parseResult(result: result)
    }
    
    private func parseResult<T: Codable>(result: APIResult) async throws -> APIResponse<T> {
        if let object: T = try self.responseHandler.parseData(result.data) {
            return APIResponse(value: object, needsRetry: result.status.needsRetry)
        } else {
            throw APIError.noData(result: result)
        }
    }
}

extension NetworkManager: ServiceType {
    func findFalcone(_ request: FindFalcone.Find.Request) async throws -> APIResponse<FindFalcone.Find.Response> {
        return try await send(api: API.findFalcone(request))
    }
    
    func retrieveToken() async throws -> APIResponse<SelectDestinations.RetrieveToken.Response> {
        return try await send(api: .retrieveToken)
    }
    
    func getPlanets() async throws -> APIResponse<[SelectDestinations.LoadPlanets.Response]> {
        return try await send(api: .getPlanets)
    }
    
    func getVehicles() async throws -> APIResponse<[SelectDestinations.LoadVehicles.Response]> {
        return try await send(api: .getVehicles)
    }
}

struct APIResponse<T: Codable> {
    let value: T
    let needsRetry: Bool
}

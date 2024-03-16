//
//  NetworkManagerMock.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcone

class NetworkManagerMock: ServiceType {
    let findFalconeResponse: APIResponse<FindFalcone.Find.Response>
    let retrieveTokenResponse: APIResponse<SelectDestinations.RetrieveToken.Response>
    let getVehiclesResponse: APIResponse<[SelectDestinations.LoadVehicles.Response]>
    let getPlanetsResponse: APIResponse<[SelectDestinations.LoadPlanets.Response]>
    
    init(
        findFalconeResponse: APIResponse<FindFalcone.Find.Response> = APIResponse(value: .mockAny(), needsRetry: false),
        retrieveTokenResponse: APIResponse<SelectDestinations.RetrieveToken.Response> = APIResponse(value: .mockAny(), needsRetry: false),
        getVehiclesResponse: APIResponse<[SelectDestinations.LoadVehicles.Response]> = APIResponse(value: [.mockAny()], needsRetry: false),
        getPlanetsResponse: APIResponse<[SelectDestinations.LoadPlanets.Response]> = APIResponse(value: [.mockAny()], needsRetry: false)
    ) {
        self.findFalconeResponse = findFalconeResponse
        self.retrieveTokenResponse = retrieveTokenResponse
        self.getVehiclesResponse = getVehiclesResponse
        self.getPlanetsResponse = getPlanetsResponse
    }
    
    func findFalcone(_ request: FindFalcone.Find.Request) async throws -> APIResponse<FindFalcone.Find.Response> {
        return findFalconeResponse
    }
    
    func retrieveToken() async throws -> APIResponse<SelectDestinations.RetrieveToken.Response> {
        return retrieveTokenResponse
    }
    
    func getVehicles() async throws -> APIResponse<[SelectDestinations.LoadVehicles.Response]> {
        return getVehiclesResponse
    }
    
    func getPlanets() async throws -> APIResponse<[SelectDestinations.LoadPlanets.Response]> {
        return getPlanetsResponse
    }
    
    
}

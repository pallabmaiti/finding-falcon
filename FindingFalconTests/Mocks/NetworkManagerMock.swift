//
//  NetworkManagerMock.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcon

class NetworkManagerMock: ServiceType {
    let findFalconResponse: APIResponse<FoundFalcon.Find.Response>
    let retrieveTokenResponse: APIResponse<FindingFalcon.RetrieveToken.Response>
    let getVehiclesResponse: APIResponse<[FindingFalcon.LoadVehicles.Response]>
    let getPlanetsResponse: APIResponse<[FindingFalcon.LoadPlanets.Response]>
    
    init(
        findFalconResponse: APIResponse<FoundFalcon.Find.Response> = APIResponse(value: .mockAny(), needsRetry: false),
        retrieveTokenResponse: APIResponse<FindingFalcon.RetrieveToken.Response> = APIResponse(value: .mockAny(), needsRetry: false),
        getVehiclesResponse: APIResponse<[FindingFalcon.LoadVehicles.Response]> = APIResponse(value: [.mockAny()], needsRetry: false),
        getPlanetsResponse: APIResponse<[FindingFalcon.LoadPlanets.Response]> = APIResponse(value: [.mockAny()], needsRetry: false)
    ) {
        self.findFalconResponse = findFalconResponse
        self.retrieveTokenResponse = retrieveTokenResponse
        self.getVehiclesResponse = getVehiclesResponse
        self.getPlanetsResponse = getPlanetsResponse
    }
    
    func findFalcon(_ request: FoundFalcon.Find.Request) async throws -> APIResponse<FoundFalcon.Find.Response> {
        return findFalconResponse
    }
    
    func retrieveToken() async throws -> APIResponse<FindingFalcon.RetrieveToken.Response> {
        return retrieveTokenResponse
    }
    
    func getVehicles() async throws -> APIResponse<[FindingFalcon.LoadVehicles.Response]> {
        return getVehiclesResponse
    }
    
    func getPlanets() async throws -> APIResponse<[FindingFalcon.LoadPlanets.Response]> {
        return getPlanetsResponse
    }
    
    
}

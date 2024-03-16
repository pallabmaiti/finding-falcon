//
//  FindFalconPlanetsAndVehiclesWorkerTests.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcon

final class FindFalconPlanetsAndVehiclesWorkerTests: XCTestCase {
    func test_getPlanetsAndVehicles() async throws {
        let planets: [FindingFalcon.LoadVehicles.Response] = [.mockAny()]
        let vehicles: [FindingFalcon.LoadPlanets.Response] = [.mockAny()]
        let getVehiclesResponse: APIResponse<[FindingFalcon.LoadVehicles.Response]> = APIResponse(value: planets, needsRetry: false)
        let getPlanetsResponse: APIResponse<[FindingFalcon.LoadPlanets.Response]> = APIResponse(value: vehicles, needsRetry: false)
        let networkManager = NetworkManagerMock(getVehiclesResponse: getVehiclesResponse, getPlanetsResponse: getPlanetsResponse)
        
        let worker = FindFalconPlanetsAndVehiclesWorker(networkManager: networkManager)
        
        let response = try await worker.getPlanetsAndVehicles()
        
        XCTAssertEqual(response.planets, getPlanetsResponse.value)
        XCTAssertEqual(response.vehicles, getVehiclesResponse.value)
    }
}

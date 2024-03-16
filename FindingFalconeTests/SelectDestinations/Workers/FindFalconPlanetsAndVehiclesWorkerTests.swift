//
//  FindFalconPlanetsAndVehiclesWorkerTests.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcone

final class FindFalconPlanetsAndVehiclesWorkerTests: XCTestCase {
    func test_getPlanetsAndVehicles() async throws {
        let planets: [SelectDestinations.LoadVehicles.Response] = [.mockAny()]
        let vehicles: [SelectDestinations.LoadPlanets.Response] = [.mockAny()]
        let getVehiclesResponse: APIResponse<[SelectDestinations.LoadVehicles.Response]> = APIResponse(value: planets, needsRetry: false)
        let getPlanetsResponse: APIResponse<[SelectDestinations.LoadPlanets.Response]> = APIResponse(value: vehicles, needsRetry: false)
        let networkManager = NetworkManagerMock(getVehiclesResponse: getVehiclesResponse, getPlanetsResponse: getPlanetsResponse)
        
        let worker = PlanetsAndVehiclesWorker(networkManager: networkManager)
        
        let response = try await worker.getPlanetsAndVehicles()
        
        XCTAssertEqual(response.planets, getPlanetsResponse.value)
        XCTAssertEqual(response.vehicles, getVehiclesResponse.value)
    }
}

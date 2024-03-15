//
//  FindFalconInteractorTests.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcon

final class FindFalconInteractorTests: XCTestCase {
    @MainActor func test_retrieveToken() async throws {
        let response: FindingFalcon.RetrieveToken.Response = .mockAny()
        let tokenWorker = FindFalconTokenWorkerMock(response: response)
        
        let presenter = FindFalconPresenterMock()

        let interactor = FindFalconInteractor()
        interactor.presenter = presenter
        interactor.tokenWorker = tokenWorker

        try await interactor.retrieveToken()
        
        XCTAssertTrue(presenter.presentTokenCalled)
        XCTAssertEqual(presenter.presentTokenResponse, response)
    }
    
    @MainActor func test_getPlanetsAndVehicles() async throws {
        let response: FindingFalcon.LoadPlanetsAndVehicles.Response = .mockAny()
        let planetsAndVehiclesWorker = FindFalconPlanetsAndVehiclesWorkerMock(response: response)
        
        let presenter = FindFalconPresenterMock()

        let interactor = FindFalconInteractor()
        interactor.presenter = presenter
        interactor.planetsAndVehiclesWorker = planetsAndVehiclesWorker

        try await interactor.getPlanetsAndVehicles()
        
        XCTAssertTrue(presenter.presentPlanetsAndVehiclesCalled)
        XCTAssertEqual(presenter.presentPlanetsAndVehiclesResponse, response)
    }
}

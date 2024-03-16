//
//  SelectDestinationsInteractorTests.swift
//  SelectDestinationsTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcone

final class SelectDestinationsInteractorTests: XCTestCase {
    @MainActor func test_retrieveToken() async throws {
        let response: SelectDestinations.RetrieveToken.Response = .mockAny()
        let tokenWorker = TokenWorkerMock(response: response)
        
        let presenter = SelectDestinationsPresenterMock()

        let interactor = SelectDestinationsInteractor()
        interactor.presenter = presenter
        interactor.tokenWorker = tokenWorker

        try await interactor.retrieveToken()
        
        XCTAssertTrue(presenter.presentTokenCalled)
        XCTAssertEqual(presenter.presentTokenResponse, response)
    }
    
    @MainActor func test_getPlanetsAndVehicles() async throws {
        let response: SelectDestinations.LoadPlanetsAndVehicles.Response = .mockAny()
        let planetsAndVehiclesWorker = PlanetsAndVehiclesWorkerMock(response: response)
        
        let presenter = SelectDestinationsPresenterMock()

        let interactor = SelectDestinationsInteractor()
        interactor.presenter = presenter
        interactor.planetsAndVehiclesWorker = planetsAndVehiclesWorker

        try await interactor.getPlanetsAndVehicles()
        
        XCTAssertTrue(presenter.presentPlanetsAndVehiclesCalled)
        XCTAssertEqual(presenter.presentPlanetsAndVehiclesResponse, response)
    }
}

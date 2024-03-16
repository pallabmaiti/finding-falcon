//
//  FindFalconViewTests.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcon

final class FindFalconViewTests: XCTestCase {
    
    @MainActor func test_retrieveToken() async {
        var view = FindFalconView()
        
        let interactor = FindFalconInteractorMock()
        view.interactor = interactor
        
        await view.retrieveToken()
        
        XCTAssertTrue(interactor.retrieveTokenCalled)
    }
    
    @MainActor func test_getPlanetsAndVehicles() async {
        var view = FindFalconView()
        
        let interactor = FindFalconInteractorMock()
        view.interactor = interactor
        
        await view.getPlanetsAndVehicles()
        
        XCTAssertTrue(interactor.getPlanetsAndVehiclesCalled)
    }
    
    @MainActor func test_DataStore_Vehicle_And_Planet_List() async throws {
        let presenter = FindFalconPresenter()
        let interactor = FindFalconInteractor()
                
        let vehicleName: String = .mockRandom()
        let vehicle: FindingFalcon.LoadVehicles.Response = .mockRandom(name: vehicleName, totalNo: 1, maxDistance: 200, speed: 2)
        
        let planetName: String = .mockRandom()
        let planet: FindingFalcon.LoadPlanets.Response = .mockRandom(name: planetName, distance: 300)

        let response: FindingFalcon.LoadPlanetsAndVehicles.Response = .mockRandom(planets: [planet], vehicles: [vehicle])
        let planetsAndVehiclesWorker = FindFalconPlanetsAndVehiclesWorkerMock(response: response)
        
        interactor.planetsAndVehiclesWorker = planetsAndVehiclesWorker
        
        var view = FindFalconView()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        
        XCTAssertEqual(view.dataStore.planetList, [])
        XCTAssertEqual(view.dataStore.vehicleList, [])
        XCTAssertEqual(view.dataModel.destinations.first?.planetList, [])
        XCTAssertEqual(view.dataModel.destinations.first?.vehicleList, [])
        
        await view.getPlanetsAndVehicles()
        
        XCTAssertEqual(view.dataStore.planetList, [Planet(name: planetName, distance: 300)])
        XCTAssertEqual(view.dataStore.vehicleList, [Vehicle(name: vehicleName, totalNo: 1, maxDistance: 200, speed: 2)])
        XCTAssertEqual(view.dataModel.destinations.first?.planetList, [Planet(name: planetName, distance: 300)])
        XCTAssertEqual(view.dataModel.destinations.first?.vehicleList, [Vehicle(name: vehicleName, totalNo: 1, maxDistance: 200, speed: 2)])
    }
    
    @MainActor func test_DataStore_Token() async throws {
        let presenter = FindFalconPresenter()
        let interactor = FindFalconInteractor()
                
        let token: String = .mockRandom()
        let response: FindingFalcon.RetrieveToken.Response = .mockRandom(token: token)
        let tokenWorker = FindFalconTokenWorkerMock(response: response)
        
        interactor.tokenWorker = tokenWorker
        
        var view = FindFalconView()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        
        XCTAssertNil(view.dataStore.token)
        
        await view.retrieveToken()
        
        XCTAssertEqual(view.dataStore.token, Token(token: token))
    }
    
    @MainActor func test_DataStore_isLoading() async throws {
        let presenter = FindFalconPresenter()
        let interactor = FindFalconInteractor()
                
        let tokenWorker = FindFalconTokenWorkerMock()
        
        interactor.tokenWorker = tokenWorker
        
        var view = FindFalconView()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        
        XCTAssertTrue(view.dataStore.isLoading)
        
        await view.retrieveToken()
        
        XCTAssertFalse(view.dataStore.isLoading)
    }
    
    @MainActor func test_DataFetch_onError() async throws {
        let expectation = expectation(description: "Error should occur")
        expectation.expectedFulfillmentCount = 2
        
        let interactor = FindFalconInteractorErrorMock()
                        
        var view = FindFalconView()
        view.interactor = interactor
        
        view.onError = {
            expectation.fulfill()
        }
        
        await view.getPlanetsAndVehicles()
        await view.retrieveToken()
        
        // xcodebuild on CI is not working.
        // await self.fulfillment(of: [expectation], timeout: 0.5)
        
        waitForExpectations(timeout: 0.5)
    }
    
    @MainActor func test_startAgain() async throws {
        var view = FindFalconView()
        
        let vehicle1: Vehicle = .mockRandom(name: .mockRandom(), totalNo: 1, maxDistance: 200, speed: 2)
        let vehicle2: Vehicle = .mockRandom(name: .mockRandom(), totalNo: 1, maxDistance: 200, speed: 2)
        
        let planet1: Planet = .mockRandom(name: .mockRandom(), distance: 300)
        let planet2: Planet = .mockRandom(name: .mockRandom(), distance: 300)

        view.dataStore = .mockRandom(planetList: [planet1, planet2], vehicleList: [vehicle1, vehicle2])
        
        let destination1: Destination = .mockRandom(name: .mockRandom(), planetList: [planet1, planet2], vehicleList: [vehicle1, vehicle2], selectedVehicle: vehicle1, selectedPlanet: planet2)
        let destination2: Destination = .mockRandom(name: .mockRandom(), planetList: [planet1, planet2], vehicleList: [vehicle1, vehicle2], selectedVehicle: vehicle2, selectedPlanet: planet1)
        view.dataModel = .mockRandom(destinations: [destination1, destination2])
        
        view.startAgain()
        
        XCTAssertEqual(destination1.planetList, [planet1, planet2])
        XCTAssertEqual(destination1.vehicleList, [vehicle1, vehicle2])
        XCTAssertNil(destination1.selectedVehicle)
        XCTAssertNil(destination1.selectedPlanet)
        XCTAssertEqual(destination2.planetList, [])
        XCTAssertEqual(destination2.vehicleList, [])
        XCTAssertNil(destination2.selectedVehicle)
        XCTAssertNil(destination2.selectedPlanet)
    }
}

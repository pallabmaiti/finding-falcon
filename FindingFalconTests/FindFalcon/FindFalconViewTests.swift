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
}

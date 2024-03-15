//
//  FindFalconPresenterTests.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcon

final class FindFalconPresenterTests: XCTestCase {
    func test_presentPlanetsAndVehicles() {
        let view = FindFalconDisplayMock()
        
        let presenter = FindFalconPresenter()
        presenter.view = view
        
        let response: FindingFalcon.LoadPlanetsAndVehicles.Response = .mockAny()
        presenter.presentPlanetsAndVehicles(response)

        XCTAssertTrue(view.displayPlanetsAndVehiclesCalled)
        XCTAssertEqual(view.displayPlanetsAndVehiclesViewModel?.planets, response.planets.compactMap{ Planet(name: $0.name, distance: $0.distance) })
        XCTAssertEqual(view.displayPlanetsAndVehiclesViewModel?.vehicles, response.vehicles.compactMap{ Vehicle(name: $0.name, totalNo: $0.totalNo, maxDistance: $0.maxDistance, speed: $0.speed) })
    }
    
    func test_presentToken() {
        let view = FindFalconDisplayMock()
        
        let presenter = FindFalconPresenter()
        presenter.view = view
        
        let response: FindingFalcon.RetrieveToken.Response = .mockAny()
        presenter.presentToken(response)
        
        XCTAssertTrue(view.displayTokenCalled)
        XCTAssertEqual(view.displayTokenViewModel?.token.token, response.token)
    }
}

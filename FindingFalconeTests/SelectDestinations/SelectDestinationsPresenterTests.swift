//
//  SelectDestinationsPresenterTests.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcone

final class SelectDestinationsPresenterTests: XCTestCase {
    func test_presentPlanetsAndVehicles() {
        let view = SelectDestinationsDisplayMock()
        
        let presenter = SelectDestinationsPresenter()
        presenter.view = view
        
        let response: SelectDestinations.LoadPlanetsAndVehicles.Response = .mockAny()
        presenter.presentPlanetsAndVehicles(response)

        XCTAssertTrue(view.displayPlanetsAndVehiclesCalled)
        XCTAssertEqual(view.displayPlanetsAndVehiclesViewModel?.planets, response.planets.compactMap{ Planet(name: $0.name, distance: $0.distance) })
        XCTAssertEqual(view.displayPlanetsAndVehiclesViewModel?.vehicles, response.vehicles.compactMap{ Vehicle(name: $0.name, totalNo: $0.totalNo, maxDistance: $0.maxDistance, speed: $0.speed) })
    }
    
    func test_presentToken() {
        let view = SelectDestinationsDisplayMock()
        
        let presenter = SelectDestinationsPresenter()
        presenter.view = view
        
        let response: SelectDestinations.RetrieveToken.Response = .mockAny()
        presenter.presentToken(response)
        
        XCTAssertTrue(view.displayTokenCalled)
        XCTAssertEqual(view.displayTokenViewModel?.token.token, response.token)
    }
}

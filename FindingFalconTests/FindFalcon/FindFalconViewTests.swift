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
}

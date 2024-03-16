//
//  FindFalconInteractorMock.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcon

class FindFalconInteractorMock: FindFalconBusinessLogic {
    var retrieveTokenCalled = false
    var getPlanetsAndVehiclesCalled = false
    var startAgainCalled = false
    
    func retrieveToken() async throws {
        retrieveTokenCalled = true
    }
    
    func getPlanetsAndVehicles() async throws {
        getPlanetsAndVehiclesCalled = true
    }
    
    func startAgain() {
        startAgainCalled = true
    }
}

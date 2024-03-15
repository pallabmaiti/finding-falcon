//
//  FindFalconPresenterMock.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcon

class FindFalconPresenterMock: FindFalconPresentationLogic {
    var presentPlanetsAndVehiclesCalled = false
    var presentTokenCalled = false
    var presentPlanetsAndVehiclesResponse: FindingFalcon.LoadPlanetsAndVehicles.Response?
    var presentTokenResponse: FindingFalcon.RetrieveToken.Response?
    
    func presentPlanetsAndVehicles(_ response: FindingFalcon.LoadPlanetsAndVehicles.Response) {
        presentPlanetsAndVehiclesCalled = true
        presentPlanetsAndVehiclesResponse = response
    }
    
    func presentToken(_ response: FindingFalcon.RetrieveToken.Response) {
        presentTokenCalled = true
        presentTokenResponse = response
    }
}

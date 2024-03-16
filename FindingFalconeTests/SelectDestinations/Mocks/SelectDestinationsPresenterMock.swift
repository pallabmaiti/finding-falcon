//
//  SelectDestinationsPresenterMock.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcone

class SelectDestinationsPresenterMock: SelectDestinationsPresentationLogic {
    var presentPlanetsAndVehiclesCalled = false
    var presentTokenCalled = false
    var presentPlanetsAndVehiclesResponse: SelectDestinations.LoadPlanetsAndVehicles.Response?
    var presentTokenResponse: SelectDestinations.RetrieveToken.Response?
    
    func presentPlanetsAndVehicles(_ response: SelectDestinations.LoadPlanetsAndVehicles.Response) {
        presentPlanetsAndVehiclesCalled = true
        presentPlanetsAndVehiclesResponse = response
    }
    
    func presentToken(_ response: SelectDestinations.RetrieveToken.Response) {
        presentTokenCalled = true
        presentTokenResponse = response
    }
}

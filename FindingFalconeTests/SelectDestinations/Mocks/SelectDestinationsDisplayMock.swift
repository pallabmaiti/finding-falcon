//
//  SelectDestinationsDisplayMock.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcone

class SelectDestinationsDisplayMock: SelectDestinationsDisplayLogic {
    var displayPlanetsAndVehiclesCalled = false
    var displayTokenCalled = false
    var displayPlanetsAndVehiclesViewModel: SelectDestinations.LoadPlanetsAndVehicles.ViewModel?
    var displayTokenViewModel: SelectDestinations.RetrieveToken.ViewModel?
    
    func displayPlanetsAndVehicles(viewModel: SelectDestinations.LoadPlanetsAndVehicles.ViewModel) {
        displayPlanetsAndVehiclesCalled = true
        displayPlanetsAndVehiclesViewModel = viewModel
    }
    
    func displayToken(viewModel: SelectDestinations.RetrieveToken.ViewModel) {
        displayTokenCalled = true
        displayTokenViewModel = viewModel
    }
}

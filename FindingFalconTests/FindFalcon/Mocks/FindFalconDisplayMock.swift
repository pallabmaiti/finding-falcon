//
//  FindFalconDisplayMock.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcon

class FindFalconDisplayMock: FindFalconDisplayLogic {
    var displayPlanetsAndVehiclesCalled = false
    var displayTokenCalled = false
    var displayPlanetsAndVehiclesViewModel: FindingFalcon.LoadPlanetsAndVehicles.ViewModel?
    var displayTokenViewModel: FindingFalcon.RetrieveToken.ViewModel?
    
    func displayPlanetsAndVehicles(viewModel: FindingFalcon.LoadPlanetsAndVehicles.ViewModel) {
        displayPlanetsAndVehiclesCalled = true
        displayPlanetsAndVehiclesViewModel = viewModel
    }
    
    func displayToken(viewModel: FindingFalcon.RetrieveToken.ViewModel) {
        displayTokenCalled = true
        displayTokenViewModel = viewModel
    }
}

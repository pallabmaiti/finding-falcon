//
//  FindFalconeDisplayMock.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcone

class FindFalconeDisplayMock: FindFalconeDisplayLogic {
    var displaySuccessCalled = false
    var displayFailureCalled = false
    var displayTotalTimeTakenCalled = false
    var displaySuccessViewModel: FindFalcone.Find.ViewModelSuccess?
    var displayTotalTimeTakenViewModel: FindFalcone.TotalTimeTaken.ViewModel?
    
    func displaySuccess(viewModel: FindFalcone.Find.ViewModelSuccess) {
        displaySuccessViewModel = viewModel
        displaySuccessCalled = true
    }
    
    func displayFailure(viewModel: FindFalcone.Find.ViewModelFailure) {
        displayFailureCalled = true
    }
    
    func displayTotalTimeTaken(viewModel: FindFalcone.TotalTimeTaken.ViewModel) {
        displayTotalTimeTakenViewModel = viewModel
        displayTotalTimeTakenCalled = true
    }
}

//
//  FoundFalconDisplayMock.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcon

class FoundFalconDisplayMock: FoundFalconDisplayLogic {
    var displaySuccessCalled = false
    var displayFailureCalled = false
    var displayTotalTimeTakenCalled = false
    var displaySuccessViewModel: FoundFalcon.Find.ViewModelSuccess?
    var displayTotalTimeTakenViewModel: FoundFalcon.TotalTimeTaken.ViewModel?
    
    func displaySuccess(viewModel: FoundFalcon.Find.ViewModelSuccess) {
        displaySuccessViewModel = viewModel
        displaySuccessCalled = true
    }
    
    func displayFailure(viewModel: FoundFalcon.Find.ViewModelFailure) {
        displayFailureCalled = true
    }
    
    func displayTotalTimeTaken(viewModel: FoundFalcon.TotalTimeTaken.ViewModel) {
        displayTotalTimeTakenViewModel = viewModel
        displayTotalTimeTakenCalled = true
    }
}

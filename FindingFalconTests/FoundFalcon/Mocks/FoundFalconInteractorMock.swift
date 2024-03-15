//
//  FoundFalconInteractorMock.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcon

class FoundFalconInteractorMock: FoundFalconBusinessLogic {
    var findFalconCalled = false
    var startAgainCalled = false
    var getTotalTimeTakenCalled = false
    
    func findFalcon() async throws {
        findFalconCalled = true
    }
    
    func startAgain() {
        startAgainCalled = true
    }
    
    func getTotalTimeTaken() async {
        getTotalTimeTakenCalled = true
    }
}

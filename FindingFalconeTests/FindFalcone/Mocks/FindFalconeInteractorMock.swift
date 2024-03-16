//
//  FindFalconeInteractorMock.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcone

class FindFalconeInteractorMock: FindFalconeBusinessLogic {
    var findFalconeCalled = false
    var startAgainCalled = false
    var getTotalTimeTakenCalled = false
    
    func findFalcone() async throws {
        findFalconeCalled = true
    }
    
    func startAgain() {
        startAgainCalled = true
    }
    
    func getTotalTimeTaken() async {
        getTotalTimeTakenCalled = true
    }
}

//
//  FindFalconeViewTests.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcone

final class FindFalconeViewTests: XCTestCase {
    @MainActor func test_findFalcone() async {
        var view = FindFalconeView()
        
        let interactor = FindFalconeInteractorMock()
        view.interactor = interactor
        
        await view.findFalcone()
        
        XCTAssertTrue(interactor.findFalconeCalled)
    }
    
    @MainActor func test_getTotalTimeTaken() async {
        var view = FindFalconeView()
        
        let interactor = FindFalconeInteractorMock()
        view.interactor = interactor
        
        await view.getTotalTimeTaken()
        
        XCTAssertTrue(interactor.getTotalTimeTakenCalled)
    }
    
    @MainActor func test_startAgain() async {
        var view = FindFalconeView()
        
        let interactor = FindFalconeInteractorMock()
        view.interactor = interactor
        
        view.startAgain()
        
        XCTAssertTrue(interactor.startAgainCalled)
    }
}

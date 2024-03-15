//
//  FoundFalconViewTests.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcon

final class FoundFalconViewTests: XCTestCase {
    @MainActor func test_findFalcon() async {
        var view = FoundFalconView()
        
        let interactor = FoundFalconInteractorMock()
        view.interactor = interactor
        
        await view.findFalcon()
        
        XCTAssertTrue(interactor.findFalconCalled)
    }
    
    @MainActor func test_getTotalTimeTaken() async {
        var view = FoundFalconView()
        
        let interactor = FoundFalconInteractorMock()
        view.interactor = interactor
        
        await view.getTotalTimeTaken()
        
        XCTAssertTrue(interactor.getTotalTimeTakenCalled)
    }
    
    @MainActor func test_startAgain() async {
        var view = FoundFalconView()
        
        let interactor = FoundFalconInteractorMock()
        view.interactor = interactor
        
        view.startAgain()
        
        XCTAssertTrue(interactor.startAgainCalled)
    }
}

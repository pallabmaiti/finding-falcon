//
//  FindFalconePresenterTests.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcone

final class FindFalconePresenterTests: XCTestCase {
    func test_presentFalcone_Success() {
        let view = FindFalconeDisplayMock()
        
        let presenter = FindFalconePresenter()
        presenter.view = view
        
        let planetName: String? = .mockAny()
        presenter.presentFalcone(.mockRandom(planetName: planetName, status: "success"))
        
        XCTAssertTrue(view.displaySuccessCalled)
        XCTAssertEqual(view.displaySuccessViewModel?.planetName, planetName)
    }
    
    func test_presentFalcone_Failure() {
        let view = FindFalconeDisplayMock()
        
        let presenter = FindFalconePresenter()
        presenter.view = view
        
        presenter.presentFalcone(.mockRandom(status: "false"))
        
        XCTAssertTrue(view.displayFailureCalled)
    }
    
    func test_presentTotalTimeTaken() {
        let view = FindFalconeDisplayMock()
        
        let presenter = FindFalconePresenter()
        presenter.view = view
        
        let response: FindFalcone.TotalTimeTaken.Response = .mockAny()
        presenter.presentTotalTimeTaken(response)
        
        XCTAssertTrue(view.displayTotalTimeTakenCalled)
        XCTAssertEqual(response.totalTimeTaken, view.displayTotalTimeTakenViewModel?.totalTimeTaken)
    }
}

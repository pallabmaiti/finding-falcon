//
//  FoundFalconPresenterTests.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcon

final class FoundFalconPresenterTests: XCTestCase {
    func test_presentFalcon_Success() {
        let view = FoundFalconDisplayMock()
        
        let presenter = FoundFalconPresenter()
        presenter.view = view
        
        let planetName: String? = .mockAny()
        presenter.presentFalcon(.mockRandom(planetName: planetName, status: "success"))
        
        XCTAssertTrue(view.displaySuccessCalled)
        XCTAssertEqual(view.displaySuccessViewModel?.planetName, planetName)
    }
    
    func test_presentFalcon_Failure() {
        let view = FoundFalconDisplayMock()
        
        let presenter = FoundFalconPresenter()
        presenter.view = view
        
        presenter.presentFalcon(.mockRandom(status: "false"))
        
        XCTAssertTrue(view.displayFailureCalled)
    }
    
    func test_presentTotalTimeTaken() {
        let view = FoundFalconDisplayMock()
        
        let presenter = FoundFalconPresenter()
        presenter.view = view
        
        let response: FoundFalcon.TotalTimeTaken.Response = .mockAny()
        presenter.presentTotalTimeTaken(response)
        
        XCTAssertTrue(view.displayTotalTimeTakenCalled)
        XCTAssertEqual(response.totalTimeTaken, view.displayTotalTimeTakenViewModel?.totalTimeTaken)
    }
}

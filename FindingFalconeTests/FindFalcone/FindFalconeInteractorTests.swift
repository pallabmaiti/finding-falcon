//
//  FindFalconeInteractorTests.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcone

final class FindFalconeInteractorTests: XCTestCase {
    @MainActor func test_findFalcone() async throws {        
        let interactor = FindFalconeInteractor(dataModel: .mockAny(), token: .mockAny(), onStartAgain: nil)
        
        let presenter = FindFalconePresenterMock()
        interactor.presenter = presenter
        
        let response = FindFalcone.Find.Response(planetName: .mockAny(), status: .mockAny())
        interactor.worker = FindFalconeWorkerMock(response: response)
        
        try await interactor.findFalcone()
        
        XCTAssertTrue(presenter.presentFalconCalled)
        XCTAssertEqual(response, presenter.presentFalconResponse)
    }
    
    @MainActor func test_startAgain() {
        let expectation = expectation(description: "Start Again should be called")
        expectation.expectedFulfillmentCount = 1
        
        let interactor = FindFalconeInteractor(dataModel: .mockAny(), token: .mockAny(), onStartAgain: expectation.fulfill)
        
        let presenter = FindFalconePresenterMock()
        interactor.presenter = presenter
                
        interactor.startAgain()
        
        waitForExpectations(timeout: 1.0)
    }
    
    @MainActor func test_getTotalTimeTaken() async throws {
        let dataModel: SelectDestinationsDataModel = .mockAny()
        
        let interactor = FindFalconeInteractor(dataModel: dataModel, token: .mockAny(), onStartAgain: nil)
        
        let presenter = FindFalconePresenterMock()
        interactor.presenter = presenter
                
        await interactor.getTotalTimeTaken()
        
        XCTAssertTrue(presenter.presentTotalTimeTakenCalled)
        XCTAssertEqual(dataModel.totalTimeTaken, presenter.presentTotalTimeTakenResponse?.totalTimeTaken)
    }
}

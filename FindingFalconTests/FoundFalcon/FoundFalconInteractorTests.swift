//
//  FoundFalconInteractorTests.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcon

final class FoundFalconInteractorTests: XCTestCase {
    @MainActor func test_findFalcon() async throws {        
        let interactor = FoundFalconInteractor(dataModel: .mockAny(), token: .mockAny(), onStartAgain: nil)
        
        let presenter = FoundFalconPresenterMock()
        interactor.presenter = presenter
        
        let response = FoundFalcon.Find.Response(planetName: .mockAny(), status: .mockAny())
        interactor.worker = FoundFalconWorkerMock(response: response)
        
        try await interactor.findFalcon()
        
        XCTAssertTrue(presenter.presentFalconCalled)
        XCTAssertEqual(response, presenter.presentFalconResponse)
    }
    
    @MainActor func test_startAgain() async {
        let expectation = expectation(description: "Start Again should be called")
        expectation.expectedFulfillmentCount = 1
        
        let interactor = FoundFalconInteractor(dataModel: .mockAny(), token: .mockAny(), onStartAgain: expectation.fulfill)
        
        let presenter = FoundFalconPresenterMock()
        interactor.presenter = presenter
                
        interactor.startAgain()
        
        await fulfillment(of: [expectation])
    }
    
    @MainActor func test_getTotalTimeTaken() async throws {
        let dataModel: FindFalconDataModel = .mockAny()
        
        let interactor = FoundFalconInteractor(dataModel: dataModel, token: .mockAny(), onStartAgain: nil)
        
        let presenter = FoundFalconPresenterMock()
        interactor.presenter = presenter
                
        await interactor.getTotalTimeTaken()
        
        XCTAssertTrue(presenter.presentTotalTimeTakenCalled)
        XCTAssertEqual(dataModel.totalTimeTaken, presenter.presentTotalTimeTakenResponse?.totalTimeTaken)
    }
}

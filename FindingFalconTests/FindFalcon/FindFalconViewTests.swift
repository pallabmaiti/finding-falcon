//
//  FindFalconViewTests.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
import ViewInspector
@testable import FindingFalcon

final class FindFalconViewTests: XCTestCase {
    
    @MainActor func test_ProgressView() throws {
        var view = FindFalconView()
        let progressViewText = try view.inspect().navigationView().form().section(0).progressView(0).labelView().text().string()

        XCTAssertEqual(progressViewText, "Loading...")
    }
    
    @MainActor func test_retrieveToken() async {
        var view = FindFalconView()
        
        let interactor = FindFalconInteractorMock()
        view.interactor = interactor
        
        await view.retrieveToken()
        
        XCTAssertTrue(interactor.retrieveTokenCalled)
    }
    
    @MainActor func test_getPlanetsAndVehicles() async {
        var view = FindFalconView()
        
        let interactor = FindFalconInteractorMock()
        view.interactor = interactor
        
        await view.getPlanetsAndVehicles()
        
        XCTAssertTrue(interactor.getPlanetsAndVehiclesCalled)
    }
}

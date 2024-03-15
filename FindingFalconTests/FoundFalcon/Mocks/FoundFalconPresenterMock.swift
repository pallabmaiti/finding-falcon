//
//  FoundFalconPresenterMock.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcon

class FoundFalconPresenterMock: FoundFalconPresentationLogic {
    var presentFalconCalled = false
    var presentTotalTimeTakenCalled = false
    var presentFalconResponse: FoundFalcon.Find.Response?
    var presentTotalTimeTakenResponse: FoundFalcon.TotalTimeTaken.Response?
    
    func presentFalcon(_ response: FoundFalcon.Find.Response) {
        presentFalconCalled = true
        presentFalconResponse = response
    }
    
    func presentTotalTimeTaken(_ response: FoundFalcon.TotalTimeTaken.Response) {
        presentTotalTimeTakenCalled = true
        presentTotalTimeTakenResponse = response
    }
}

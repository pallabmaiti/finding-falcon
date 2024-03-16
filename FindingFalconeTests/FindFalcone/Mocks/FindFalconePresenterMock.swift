//
//  FindFalconePresenterMock.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcone

class FindFalconePresenterMock: FindFalconePresentationLogic {
    var presentFalconCalled = false
    var presentTotalTimeTakenCalled = false
    var presentFalconResponse: FindFalcone.Find.Response?
    var presentTotalTimeTakenResponse: FindFalcone.TotalTimeTaken.Response?
    
    func presentFalcone(_ response: FindFalcone.Find.Response) {
        presentFalconCalled = true
        presentFalconResponse = response
    }
    
    func presentTotalTimeTaken(_ response: FindFalcone.TotalTimeTaken.Response) {
        presentTotalTimeTakenCalled = true
        presentTotalTimeTakenResponse = response
    }
}

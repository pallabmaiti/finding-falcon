//
//  FindFalconeWorkerMock.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcone

class FindFalconeWorkerMock: FindFalconeLogic {
    
    let response: FindFalcone.Find.Response
    
    init(response: FindFalcone.Find.Response = .mockAny()) {
        self.response = response
    }
    
    func findFalcone(_ request: FindFalcone.Find.Request) async throws -> FindFalcone.Find.Response {
        return response
    }
}

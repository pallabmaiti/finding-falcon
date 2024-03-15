//
//  FoundFalconWorkerMock.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcon

class FoundFalconWorkerMock: FoundFalconLogic {
    
    let response: FoundFalcon.Find.Response
    
    init(response: FoundFalcon.Find.Response = .mockAny()) {
        self.response = response
    }
    
    func findFalcon(_ request: FoundFalcon.Find.Request) async throws -> FoundFalcon.Find.Response {
        return response
    }
}

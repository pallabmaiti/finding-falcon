//
//  FindFalconTokenWorkerMock.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcon

class FindFalconTokenWorkerMock: FindFalconTokenLogic {
    let response: FindingFalcon.RetrieveToken.Response
    
    init(response: FindingFalcon.RetrieveToken.Response = .mockAny()) {
        self.response = response
    }
    
    func retrieveToken() async throws -> FindingFalcon.RetrieveToken.Response {
        return response
    }
}

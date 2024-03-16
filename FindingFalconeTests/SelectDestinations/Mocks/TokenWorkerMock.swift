//
//  SelectDestinationsTokenWorkerMock.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcone

class TokenWorkerMock: TokenLogic {
    let response: SelectDestinations.RetrieveToken.Response
    
    init(response: SelectDestinations.RetrieveToken.Response = .mockAny()) {
        self.response = response
    }
    
    func retrieveToken() async throws -> SelectDestinations.RetrieveToken.Response {
        return response
    }
}

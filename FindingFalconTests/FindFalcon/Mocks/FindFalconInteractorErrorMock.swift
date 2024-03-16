//
//  FindFalconInteractorErrorMock.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 16/03/24.
//

import Foundation
@testable import FindingFalcon

class FindFalconInteractorErrorMock: FindFalconBusinessLogic {
    
    func retrieveToken() async throws {
        throw APIError.noResponse
    }
    
    func getPlanetsAndVehicles() async throws {
        throw APIError.noResponse
    }
}

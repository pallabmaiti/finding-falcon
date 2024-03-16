//
//  SelectDestinationsInteractorErrorMock.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 16/03/24.
//

import Foundation
@testable import FindingFalcone

class SelectDestinationsInteractorErrorMock: SelectDestinationsBusinessLogic {
    
    func retrieveToken() async throws {
        throw APIError.noResponse
    }
    
    func getPlanetsAndVehicles() async throws {
        throw APIError.noResponse
    }
}

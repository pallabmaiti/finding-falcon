//
//  FindFalconPlanetsAndVehiclesWorkerMock.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcon

class FindFalconPlanetsAndVehiclesWorkerMock: FindFalconPlanetsAndVehiclesLogic {
    let response: FindingFalcon.LoadPlanetsAndVehicles.Response
    
    init(response: FindingFalcon.LoadPlanetsAndVehicles.Response = .mockAny()) {
        self.response = response
    }
    
    func getPlanetsAndVehicles() async throws -> FindingFalcon.LoadPlanetsAndVehicles.Response {
        return response
    }
}

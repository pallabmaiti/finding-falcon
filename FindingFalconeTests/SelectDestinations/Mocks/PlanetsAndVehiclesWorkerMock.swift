//
//  SelectDestinationsPlanetsAndVehiclesWorkerMock.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcone

class PlanetsAndVehiclesWorkerMock: PlanetsAndVehiclesLogic {
    let response: SelectDestinations.LoadPlanetsAndVehicles.Response
    
    init(response: SelectDestinations.LoadPlanetsAndVehicles.Response = .mockAny()) {
        self.response = response
    }
    
    func getPlanetsAndVehicles() async throws -> SelectDestinations.LoadPlanetsAndVehicles.Response {
        return response
    }
}

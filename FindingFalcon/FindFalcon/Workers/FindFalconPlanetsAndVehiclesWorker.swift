//
//  FindFalconPlanetsAndVehiclesWorker.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 05/03/24.
//

import Foundation

protocol FindFalconPlanetsAndVehiclesLogic {
    func getPlanetsAndVehicles() async throws -> FindingFalcon.LoadPlanetsAndVehicles.Response
}

final class FindFalconPlanetsAndVehiclesWorker: FindFalconPlanetsAndVehiclesLogic {
    let networkManager: ServiceType
    
    init(networkManager: ServiceType) {
        self.networkManager = networkManager
    }
    
    func getPlanetsAndVehicles() async throws -> FindingFalcon.LoadPlanetsAndVehicles.Response {
        let vehicles = try await networkManager.getVehicles()
        let planets = try await networkManager.getPlanets()
        return FindingFalcon.LoadPlanetsAndVehicles.Response(planets: planets.value, vehicles: vehicles.value)
    }
}

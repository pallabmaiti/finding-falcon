//
//  PlanetsAndVehiclesWorker.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 05/03/24.
//

import Foundation

protocol PlanetsAndVehiclesLogic {
    func getPlanetsAndVehicles() async throws -> SelectDestinations.LoadPlanetsAndVehicles.Response
}

final class PlanetsAndVehiclesWorker: PlanetsAndVehiclesLogic {
    let networkManager: ServiceType
    
    init(networkManager: ServiceType) {
        self.networkManager = networkManager
    }
    
    func getPlanetsAndVehicles() async throws -> SelectDestinations.LoadPlanetsAndVehicles.Response {
        let vehicles = try await networkManager.getVehicles()
        let planets = try await networkManager.getPlanets()
        return SelectDestinations.LoadPlanetsAndVehicles.Response(planets: planets.value, vehicles: vehicles.value)
    }
}

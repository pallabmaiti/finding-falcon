//
// SelectDestinationsInteractor.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 04/03/24.
//

import Foundation

protocol SelectDestinationsBusinessLogic {
    func retrieveToken() async throws
    func getPlanetsAndVehicles() async throws
}

@MainActor
final class SelectDestinationsInteractor: SelectDestinationsBusinessLogic {
    var presenter: SelectDestinationsPresentationLogic?
    var tokenWorker: TokenLogic?
    var planetsAndVehiclesWorker: PlanetsAndVehiclesLogic?
    
    func retrieveToken() async throws {
        if let response = try await tokenWorker?.retrieveToken() {
            presenter?.presentToken(response)
        }
    }
    
    func getPlanetsAndVehicles() async throws {
        if let response = try await planetsAndVehiclesWorker?.getPlanetsAndVehicles() {
            presenter?.presentPlanetsAndVehicles(response)
        }
    }
}

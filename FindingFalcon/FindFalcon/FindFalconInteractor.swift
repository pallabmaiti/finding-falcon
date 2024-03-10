//
//  FindFalconInteractor.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 04/03/24.
//

import Foundation

protocol FindFalconBusinessLogic {
    func retrieveToken() async throws
    func getPlanetsAndVehicles() async throws
}

@MainActor
final class FindFalconInteractor: FindFalconBusinessLogic {
    var presenter: FindFalconPresentationLogic?
    var tokenWorker: FindFalconTokenLogic?
    var planetsAndVehiclesWorker: FindFalconPlanetsAndVehiclesLogic?
    
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

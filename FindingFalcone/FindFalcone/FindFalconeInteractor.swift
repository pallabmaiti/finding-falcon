//
// FindFalconeInteractor.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 10/03/24.
//

import Foundation

protocol FindFalconeBusinessLogic {
    func findFalcone() async throws
    func startAgain()
    func getTotalTimeTaken() async
}

@MainActor
final class FindFalconeInteractor: FindFalconeBusinessLogic {
    var presenter: FindFalconePresentationLogic?
    var worker: FindFalconeLogic?
    
    private let dataModel: SelectDestinationsDataModel
    private let token: Token?
    private let onStartAgain: (() -> Void)?

    init(
        dataModel: SelectDestinationsDataModel,
        token: Token?,
        onStartAgain: (() -> Void)?
    ) {
        self.dataModel = dataModel
        self.token = token
        self.onStartAgain = onStartAgain
    }
    
    func findFalcone() async throws {
        guard let token = token?.token else {
            return
        }
        var planetNames = [String]()
        var vehicleNames = [String]()
        dataModel.destinations.forEach { destination in
            if let name = destination.selectedVehicle?.name {
                vehicleNames.append(name)
            }
            if let name = destination.selectedPlanet?.name {
                planetNames.append(name)
            }
        }
        guard !planetNames.isEmpty, !vehicleNames.isEmpty, planetNames.count == vehicleNames.count else {
            return
        }
        let request = FindFalcone.Find.Request(token: token, planetNames: planetNames, vehicleNames: vehicleNames)
        if let response = try await worker?.findFalcone(request) {
            presenter?.presentFalcone(response)
        }
    }
    
    nonisolated func startAgain() {
        onStartAgain?()
    }
    
    func getTotalTimeTaken() async {
        presenter?.presentTotalTimeTaken(FindFalcone.TotalTimeTaken.Response(totalTimeTaken: dataModel.totalTimeTaken))
    }
}

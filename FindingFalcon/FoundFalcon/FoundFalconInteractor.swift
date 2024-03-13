//
//  FoundFalconInteractor.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 10/03/24.
//

import Foundation

protocol FoundFalconBusinessLogic {
    func findFalcon() async throws
    func startAgain()
    func getTotalTimeTaken() async
}

@MainActor
final class FoundFalconInteractor: FoundFalconBusinessLogic {
    var presenter: FoundFalconPresentationLogic?
    var worker: FoundFalconLogic?
    
    private let dataModel: FindFalconDataModel
    private let token: Token?
    private let onStartAgain: () -> Void

    init(
        dataModel: FindFalconDataModel,
        token: Token?,
        onStartAgain: @escaping () -> Void
    ) {
        self.dataModel = dataModel
        self.token = token
        self.onStartAgain = onStartAgain
    }
    
    func findFalcon() async throws {
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
        let request = FoundFalcon.Find.Request(token: token, planetNames: planetNames, vehicleNames: vehicleNames)
        if let response = try await worker?.findFalcon(request) {
            presenter?.presentFalcon(response)
        }
    }
    
    nonisolated func startAgain() {
        onStartAgain()
    }
    
    func getTotalTimeTaken() async {
        presenter?.presentTotalTimeTaken(FoundFalcon.TotalTimeTaken.Response(totalTimeTaken: dataModel.totalTimeTaken))
    }
}

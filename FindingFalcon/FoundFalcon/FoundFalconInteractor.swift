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
    
    private let selectedVehicle1: Vehicle?
    private let selectedVehicle2: Vehicle?
    private let selectedVehicle3: Vehicle?
    private let selectedVehicle4: Vehicle?
    
    private let selectedPlanet1: Planet?
    private let selectedPlanet2: Planet?
    private let selectedPlanet3: Planet?
    private let selectedPlanet4: Planet?
    private let token: Token?
    private let totalTimeTaken: Int
    private let onStartAgain: () -> Void

    init(
        selectedVehicle1: Vehicle?,
        selectedVehicle2: Vehicle?,
        selectedVehicle3: Vehicle?,
        selectedVehicle4: Vehicle?,
        selectedPlanet1: Planet?,
        selectedPlanet2: Planet?,
        selectedPlanet3: Planet?,
        selectedPlanet4: Planet?,
        token: Token?,
        totalTimeTaken: Int,
        onStartAgain: @escaping () -> Void
    ) {
        self.selectedVehicle1 = selectedVehicle1
        self.selectedVehicle2 = selectedVehicle2
        self.selectedVehicle3 = selectedVehicle3
        self.selectedVehicle4 = selectedVehicle4
        self.selectedPlanet1 = selectedPlanet1
        self.selectedPlanet2 = selectedPlanet2
        self.selectedPlanet3 = selectedPlanet3
        self.selectedPlanet4 = selectedPlanet4
        self.token = token
        self.totalTimeTaken = totalTimeTaken
        self.onStartAgain = onStartAgain
    }
    
    func findFalcon() async throws {
        guard let token = token?.token else {
            return
        }
        guard let v1 = selectedVehicle1,
              let v2 = selectedVehicle1,
              let v3 = selectedVehicle1,
              let v4 = selectedVehicle1,
              let p1 = selectedPlanet1,
              let p2 = selectedPlanet2,
              let p3 = selectedPlanet3,
              let p4 = selectedPlanet4 else {
            return
        }
        let request = FoundFalcon.Find.Request(token: token, planetNames: [p1.name, p2.name, p3.name, p4.name], vehicleNames: [v1.name, v2.name, v3.name, v4.name])
        if let response = try await worker?.findFalcon(request) {
            presenter?.presentFalcon(response)
        }
    }
    
    nonisolated func startAgain() {
        onStartAgain()
    }
    
    func getTotalTimeTaken() async {
        presenter?.presentTotalTimeTaken(FoundFalcon.TotalTimeTaken.Response(totalTimeTaken: totalTimeTaken))
    }
}

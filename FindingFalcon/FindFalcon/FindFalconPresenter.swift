//
//  FindFalconPresenter.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 04/03/24.
//

import Foundation

protocol FindFalconPresentationLogic {
    func presentPlanetsAndVehicles(_ response: FindingFalcon.LoadPlanetsAndVehicles.Response)
    func presentToken(_ response: FindingFalcon.RetrieveToken.Response)
}

final class FindFalconPresenter: FindFalconPresentationLogic {
    var view: FindFalconDisplayLogic?
    
    func presentPlanetsAndVehicles(_ response: FindingFalcon.LoadPlanetsAndVehicles.Response) {
        let planets = response.planets.compactMap{ Planet(name: $0.name, distance: $0.distance) }
        let vehicles = response.vehicles.compactMap { Vehicle(name: $0.name, totalNo: $0.totalNo, maxDistance: $0.maxDistance, speed: $0.speed) }
        let viewModel = FindingFalcon.LoadPlanetsAndVehicles.ViewModel(vehicles: vehicles, planets: planets)
        view?.displayPlanetsAndVehicles(viewModel: viewModel)
    }
    
    func presentToken(_ response: FindingFalcon.RetrieveToken.Response) {
        view?.displayToken(viewModel: FindingFalcon.RetrieveToken.ViewModel(token: Token(token: response.token)))
    }
}

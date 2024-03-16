//
// SelectDestinationsPresenter.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 04/03/24.
//

import Foundation

protocol SelectDestinationsPresentationLogic {
    func presentPlanetsAndVehicles(_ response: SelectDestinations.LoadPlanetsAndVehicles.Response)
    func presentToken(_ response: SelectDestinations.RetrieveToken.Response)
}

final class SelectDestinationsPresenter: SelectDestinationsPresentationLogic {
    var view: SelectDestinationsDisplayLogic?
    
    func presentPlanetsAndVehicles(_ response: SelectDestinations.LoadPlanetsAndVehicles.Response) {
        let planets = response.planets.compactMap{ Planet(name: $0.name, distance: $0.distance) }
        let vehicles = response.vehicles.compactMap { Vehicle(name: $0.name, totalNo: $0.totalNo, maxDistance: $0.maxDistance, speed: $0.speed) }
        let viewModel = SelectDestinations.LoadPlanetsAndVehicles.ViewModel(vehicles: vehicles, planets: planets)
        view?.displayPlanetsAndVehicles(viewModel: viewModel)
    }
    
    func presentToken(_ response: SelectDestinations.RetrieveToken.Response) {
        view?.displayToken(viewModel: SelectDestinations.RetrieveToken.ViewModel(token: Token(token: response.token)))
    }
}

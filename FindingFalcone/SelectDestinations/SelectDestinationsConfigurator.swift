//
// SelectDestinationsConfigurator.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 05/03/24.
//

import SwiftUI

extension SelectDestinationsView {
    @MainActor func configureView() -> some View {
        let presenter = SelectDestinationsPresenter()
        let interactor = SelectDestinationsInteractor()

        let apiClient = URLSessionClient(
            session: URLSession(
                configuration: .default
            )
        )
        let responseHandler = ResponseHandler()
        let networkManager = NetworkManager(
            apiClient: apiClient,
            responseHandler: responseHandler
        )
        
        let tokenWorker = TokenWorker(networkManager: networkManager)
        let planetsAndVehiclesWorker = PlanetsAndVehiclesWorker(networkManager: networkManager)
        
        interactor.tokenWorker = tokenWorker
        interactor.planetsAndVehiclesWorker = planetsAndVehiclesWorker
        
        var view = self
        view.interactor = interactor
        view.router = SelectDestinationsRouter()
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}

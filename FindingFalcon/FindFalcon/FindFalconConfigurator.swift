//
//  FindFalconConfigurator.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 05/03/24.
//

import SwiftUI

extension FindFalconView {
    func configureView() -> some View {
        let presenter = FindFalconPresenter()
        let interactor = FindFalconInteractor()

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
        
        let tokenWorker = FindFalconTokenWorker(networkManager: networkManager)
        let planetsAndVehiclesWorker = FindFalconPlanetsAndVehiclesWorker(networkManager: networkManager)
        
        interactor.tokenWorker = tokenWorker
        interactor.planetsAndVehiclesWorker = planetsAndVehiclesWorker
        
        var view = self
        view.interactor = interactor
        view.router = FindFalconRouter()
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}

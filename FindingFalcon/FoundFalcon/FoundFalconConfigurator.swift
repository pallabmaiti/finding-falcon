//
//  FoundFalconConfigurator.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 10/03/24.
//

import Foundation
import SwiftUI

extension FoundFalconView {
    func configureView(
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
    ) -> some View {
        let presenter = FoundFalconPresenter()
        let interactor = FoundFalconInteractor(
            selectedVehicle1: selectedVehicle1, 
            selectedVehicle2: selectedVehicle2,
            selectedVehicle3: selectedVehicle3, 
            selectedVehicle4: selectedVehicle4,
            selectedPlanet1: selectedPlanet1,
            selectedPlanet2: selectedPlanet2,
            selectedPlanet3: selectedPlanet3,
            selectedPlanet4: selectedPlanet4,
            token: token,
            totalTimeTaken: totalTimeTaken,
            onStartAgain: onStartAgain
        )
        
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
        let worker = FoundFalconWorker(networkManager: networkManager)
        
        interactor.worker = worker
        
        var view = self
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}

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
        dataModel: FindFalconDataModel,
        token: Token?,
        onStartAgain: @escaping () -> Void
    ) -> some View {
        let presenter = FoundFalconPresenter()
        let interactor = FoundFalconInteractor(
            dataModel: dataModel,
            token: token,
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

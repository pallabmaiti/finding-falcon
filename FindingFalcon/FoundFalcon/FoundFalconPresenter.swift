//
//  FoundFalconPresenter.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 10/03/24.
//

import Foundation

protocol FoundFalconPresentationLogic {
    func presentFalcon(_ response: FoundFalcon.Find.Response)
    func presentTotalTimeTaken(_ response: FoundFalcon.TotalTimeTaken.Response)
}

final class FoundFalconPresenter: FoundFalconPresentationLogic {
    var view: FoundFalconDisplayLogic?
        
    func presentFalcon(_ response: FoundFalcon.Find.Response) {
        if response.status == "success" {
            view?.displaySuccess(viewModel: FoundFalcon.Find.ViewModelSuccess(planetName: response.planetName))
        } else {
            view?.displayFailure(viewModel: FoundFalcon.Find.ViewModelFailure())
        }
    }
    
    func presentTotalTimeTaken(_ response: FoundFalcon.TotalTimeTaken.Response) {
        view?.displayTotalTimeTaken(viewModel: FoundFalcon.TotalTimeTaken.ViewModel(totalTimeTaken: response.totalTimeTaken))
    }
}

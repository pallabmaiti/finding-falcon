//
// FindFalconePresenter.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 10/03/24.
//

import Foundation

protocol FindFalconePresentationLogic {
    func presentFalcone(_ response: FindFalcone.Find.Response)
    func presentTotalTimeTaken(_ response: FindFalcone.TotalTimeTaken.Response)
}

final class FindFalconePresenter: FindFalconePresentationLogic {
    var view: FindFalconeDisplayLogic?
        
    func presentFalcone(_ response: FindFalcone.Find.Response) {
        if response.status == "success" {
            view?.displaySuccess(viewModel: FindFalcone.Find.ViewModelSuccess(planetName: response.planetName))
        } else {
            view?.displayFailure(viewModel: FindFalcone.Find.ViewModelFailure())
        }
    }
    
    func presentTotalTimeTaken(_ response: FindFalcone.TotalTimeTaken.Response) {
        view?.displayTotalTimeTaken(viewModel: FindFalcone.TotalTimeTaken.ViewModel(totalTimeTaken: response.totalTimeTaken))
    }
}

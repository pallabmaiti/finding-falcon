//
// SelectDestinationsView.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 04/03/24.
//

import SwiftUI

protocol SelectDestinationsDisplayLogic {
    func displayPlanetsAndVehicles(viewModel: SelectDestinations.LoadPlanetsAndVehicles.ViewModel)
    func displayToken(viewModel: SelectDestinations.RetrieveToken.ViewModel)
}

struct SelectDestinationsView: View {
    var interactor: SelectDestinationsBusinessLogic?
    var router: SelectDestinationsRouter?
    
    @ObservedObject var dataStore = SelectDestinationsDataStore()
    @ObservedObject var dataModel = SelectDestinationsDataModel()
    
    var onError: (() -> Void)?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select planets you want to search in:")) {
                    if dataStore.isLoading {
                        ProgressView("Loading...")
                    } else {
                        ForEach(dataModel.destinations) { destination in
                            DestinationSelectionView(
                                destination: destination,
                                onVehicleSelect: {
                                    dataModel.updateNextDestinationVehicleList(destination: destination)
                                },
                                onPlanetSelect: {
                                    dataModel.updateNextDestinationPlanetList(destination: destination)
                                }
                            )
                            .disabled(destination.planetList.count == 0 || destination.vehicleList.count == 0)
                        }
                    }
                }
                Section(header: Text("Time taken:")) {
                    timeTakenView
                }
                Section(header: Text("Find Falcone:")) {
                    NavigationLink() {
                        navigateToNextScreen
                    } label: {
                        Text("Find Falcone")
                    }
                    .disabled(dataModel.shouldFindFalconeDisabled)
                }
            }
            .onAppear{
                Task {
                    await getPlanetsAndVehicles()
                    await retrieveToken()
                }
            }
            .navigationTitle("Find Falcone")
            .padding()
        }
        .navigationViewStyle(.stack)
    }
    
    private var navigateToNextScreen: some View {
        router?.navigateToNextScreen(
            dataModel: dataModel,
            token: dataStore.token,
            onStartAgain: {
                startAgain()
            }
        )
    }
    
    private var timeTakenView: some View {
        VStack {
            Text("\(dataModel.totalTimeTaken)")
                .font(.largeTitle)
        }
    }
}

extension SelectDestinationsView: SelectDestinationsDisplayLogic {
    func displayPlanetsAndVehicles(viewModel: SelectDestinations.LoadPlanetsAndVehicles.ViewModel) {
        dataStore.planetList = viewModel.planets
        dataStore.vehicleList = viewModel.vehicles
        
        dataModel.destinations.first?.planetList = viewModel.planets
        dataModel.destinations.first?.vehicleList = viewModel.vehicles
    }
    
    func displayToken(viewModel: SelectDestinations.RetrieveToken.ViewModel) {
        dataStore.token = viewModel.token
        dataStore.isLoading = false
    }
}

extension SelectDestinationsView {
    func retrieveToken() async {
        do {
            try await interactor?.retrieveToken()
        } catch {
            showError(error)
        }
    }
    
    func getPlanetsAndVehicles() async {
        do {
            try await interactor?.getPlanetsAndVehicles()
        } catch {
            showError(error)
        }
    }
    
    func startAgain() {
        dataModel.reset()
        dataModel.destinations.first?.planetList = dataStore.planetList
        dataModel.destinations.first?.vehicleList = dataStore.vehicleList
    }
    
    func showError(_ error: Error) {
        onError?()
    }
}

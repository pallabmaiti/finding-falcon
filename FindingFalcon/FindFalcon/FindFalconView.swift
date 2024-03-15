//
//  FindFalconView.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 04/03/24.
//

import SwiftUI
import Combine

protocol FindFalconDisplayLogic {
    func displayPlanetsAndVehicles(viewModel: FindingFalcon.LoadPlanetsAndVehicles.ViewModel)
    func displayToken(viewModel: FindingFalcon.RetrieveToken.ViewModel)
}

struct FindFalconView: View {
    var interactor: FindFalconBusinessLogic?
    var router: FindFalconRouter?
    
    @State private var dataStore = FindFalconDataStore()
    @State private var dataModel = FindFalconDataModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select planets you want to search in:")) {
                    if dataStore.isLoading {
                        ProgressView("Loading...")
                    } else {
                        ForEach(dataModel.destinations) { destination in
                            DestinationView(
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
                Section(header: Text("Find Falcon:")) {
                    NavigationLink() {
                        navigateToNextScreen
                    } label: {
                        Text("Find Falcon")
                    }
                    .disabled(dataModel.shouldButtonDisabled)
                }
            }
            .onAppear{
                Task {
                    await getPlanetsAndVehicles()
                    await retrieveToken()
                    dataStore.isLoading = false
                }
            }
            .navigationTitle("Find Falcon")
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

extension FindFalconView: FindFalconDisplayLogic {
    func displayPlanetsAndVehicles(viewModel: FindingFalcon.LoadPlanetsAndVehicles.ViewModel) {
        dataStore.planetList = viewModel.planets
        dataStore.vehicleList = viewModel.vehicles
        
        dataModel.destinations.first?.planetList = viewModel.planets
        dataModel.destinations.first?.vehicleList = viewModel.vehicles
    }
    
    func displayToken(viewModel: FindingFalcon.RetrieveToken.ViewModel) {
        dataStore.token = viewModel.token
    }
}

extension FindFalconView {
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
    
    private func startAgain() {
        dataModel.reset()
        dataModel.destinations.first?.planetList = dataStore.planetList
        dataModel.destinations.first?.vehicleList = dataStore.vehicleList
    }
    
    private func showError(_ error: Error) {
        print(error.localizedDescription)
    }
}

//#Preview {
//    FindFalconView().configureView()
//}

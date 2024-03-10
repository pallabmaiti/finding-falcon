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
    
    @ObservedObject private var dataStore = FindFalconDataStore()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select planets you want to search in:")) {
                    if dataStore.isLoading {
                        ProgressView("Loading...")
                    } else {
                        destination1
                        destination2
                        destination3
                        destination4
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
                    .disabled(dataStore.selectedVehicle1 == nil || dataStore.selectedVehicle2 == nil || dataStore.selectedVehicle3 == nil || dataStore.selectedVehicle4 == nil)
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
            selectedVehicle1: dataStore.selectedVehicle1,
            selectedVehicle2: dataStore.selectedVehicle2,
            selectedVehicle3: dataStore.selectedVehicle3,
            selectedVehicle4: dataStore.selectedVehicle4,
            selectedPlanet1: dataStore.selectedPlanet1,
            selectedPlanet2: dataStore.selectedPlanet2,
            selectedPlanet3: dataStore.selectedPlanet3,
            selectedPlanet4: dataStore.selectedPlanet4,
            token: dataStore.token,
            totalTimeTaken: dataStore.totalTimeTaken,
            onStartAgain: {
                startAgain()
            }
        )
    }
    
    private var timeTakenView: some View {
        VStack {
            Text("\(dataStore.t1 + dataStore.t2 + dataStore.t3 + dataStore.t4)")
                .font(.largeTitle)
        }
    }
    
    private var destination1: some View {
        DestinationView(
            name: "Destination 1",
            planetList: $dataStore.planetList1,
            vehicleList: $dataStore.vehicleList1,
            selectedVehicle: $dataStore.selectedVehicle1,
            selectedPlanet: $dataStore.selectedPlanet1,
            vehicleListPassthroughSubject: dataStore.vLPS1,
            planetListPassthroughSubject: dataStore.pLPS1
        )
        .onReceive(dataStore.vLPS1, perform: { list in
            dataStore.updateDestinationVehicleList(destination: .one, list: list)
        })
        .onReceive(dataStore.pLPS1, perform: { list in
            dataStore.updateDestinationPlanetList(destination: .one, list: list)
        })
    }
    
    private var destination2: some View {
        DestinationView(
            name: "Destination 2",
            planetList: $dataStore.planetList2,
            vehicleList: $dataStore.vehicleList2,
            selectedVehicle: $dataStore.selectedVehicle2,
            selectedPlanet: $dataStore.selectedPlanet2,
            vehicleListPassthroughSubject: dataStore.vLPS2,
            planetListPassthroughSubject: dataStore.pLPS2
        )
        .onReceive(dataStore.vLPS2, perform: { list in
            dataStore.updateDestinationVehicleList(destination: .two, list: list)
        })
        .onReceive(dataStore.pLPS2, perform: { list in
            dataStore.updateDestinationPlanetList(destination: .two, list: list)
        })
        .disabled(dataStore.planetList2.count == 0 || dataStore.vehicleList2.count == 0)
    }
    
    private var destination3: some View {
        DestinationView(
            name: "Destination 3",
            planetList: $dataStore.planetList3,
            vehicleList: $dataStore.vehicleList3,
            selectedVehicle: $dataStore.selectedVehicle3,
            selectedPlanet: $dataStore.selectedPlanet3,
            vehicleListPassthroughSubject: dataStore.vLPS3,
            planetListPassthroughSubject: dataStore.pLPS3
        )
        .onReceive(dataStore.vLPS3, perform: { list in
            dataStore.updateDestinationVehicleList(destination: .three, list: list)
        })
        .onReceive(dataStore.pLPS3, perform: { list in
            dataStore.updateDestinationPlanetList(destination: .three, list: list)
        })
        .disabled(dataStore.planetList3.count == 0 || dataStore.vehicleList3.count == 0)
    }
    
    private var destination4: some View {
        DestinationView(
            name: "Destination 4",
            planetList: $dataStore.planetList4,
            vehicleList: $dataStore.vehicleList4,
            selectedVehicle: $dataStore.selectedVehicle4,
            selectedPlanet: $dataStore.selectedPlanet4,
            vehicleListPassthroughSubject: dataStore.vLPS4,
            planetListPassthroughSubject: dataStore.pLPS4
        )
        .onReceive(dataStore.vLPS4, perform: { list in
            dataStore.updateDestinationVehicleList(destination: .four, list: list)
        })
        .disabled(dataStore.planetList4.count == 0 || dataStore.vehicleList4.count == 0)
    }
}

extension FindFalconView: FindFalconDisplayLogic {
    func displayPlanetsAndVehicles(viewModel: FindingFalcon.LoadPlanetsAndVehicles.ViewModel) {
        dataStore.planetList1 = viewModel.planets
        dataStore.vehicleList1 = viewModel.vehicles
    }
    
    func displayToken(viewModel: FindingFalcon.RetrieveToken.ViewModel) {
        dataStore.token = viewModel.token
    }
}

extension FindFalconView {
    private func retrieveToken() async {
        do {
            try await interactor?.retrieveToken()
        } catch {
            showError(error)
        }
    }
    
    private func getPlanetsAndVehicles() async {
        do {
            try await interactor?.getPlanetsAndVehicles()
        } catch {
            showError(error)
        }
    }
    
    private func startAgain() {
        dataStore.reset()
    }
    
    private func showError(_ error: Error) {
        print(error.localizedDescription)
    }
}

#Preview {
    FindFalconView().configureView()
}

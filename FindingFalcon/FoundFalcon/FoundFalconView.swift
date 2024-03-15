//
//  FoundFalconView.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 10/03/24.
//

import SwiftUI

protocol FoundFalconDisplayLogic {
    func displaySuccess(viewModel: FoundFalcon.Find.ViewModelSuccess)
    func displayFailure(viewModel: FoundFalcon.Find.ViewModelFailure)
    func displayTotalTimeTaken(viewModel: FoundFalcon.TotalTimeTaken.ViewModel)
}

struct FoundFalconView: View {
    @Environment(\.dismiss) var dismiss
    var interactor: FoundFalconBusinessLogic?
        
    @ObservedObject private var dataStore = FoundFalconDataStore()

    var body: some View {
        VStack {
            if dataStore.isLoading {
                ProgressView()
            } else {
                if dataStore.isSuccess {
                    successView
                } else {
                    failedView
                }
            }
        }
        .onAppear{
            Task {
                await getTotalTimeTaken()
                await findFalcon()
                dataStore.isLoading = false
            }
        }
    }
    
    private var successView: some View {
        VStack {
            Text("Success! Congratulations on Finding Falcone. King Shan is mighty Pleased.")
                .font(.title)
                .multilineTextAlignment(.center)
            VStack {
                Text("Time taken: \(dataStore.totalTimeTaken)")
                    .font(.title2)
                Text("Planet found: \(dataStore.planetName ?? "")")
                    .font(.title2)
            }
            startAgainButtonView
        }
    }
    
    private var failedView: some View {
        VStack {
            Text("Failed! King Shan is very angry.")
                .font(.title)
                .multilineTextAlignment(.center)
            startAgainButtonView
        }
        .padding(20)
    }
    
    private var startAgainButtonView: some View {
        Button {
            startAgain()
            dismiss()
        } label: {
            Text("Start Again")
                .multilineTextAlignment(.center)
                .frame(width: 200.0, height: 60.0)
        }
        .buttonStyle(.bordered)
    }
}

extension FoundFalconView: FoundFalconDisplayLogic {
    func displaySuccess(viewModel: FoundFalcon.Find.ViewModelSuccess) {
        dataStore.planetName = viewModel.planetName
        dataStore.isSuccess = true
    }
    
    func displayFailure(viewModel: FoundFalcon.Find.ViewModelFailure) {
        dataStore.isSuccess = false
    }
    
    func displayTotalTimeTaken(viewModel: FoundFalcon.TotalTimeTaken.ViewModel) {
        dataStore.totalTimeTaken = viewModel.totalTimeTaken
    }
}

extension FoundFalconView {
    func findFalcon() async {
        do {
            try await interactor?.findFalcon()
        } catch {
            
        }
    }
    
    func startAgain() {
        interactor?.startAgain()
    }
    
    func getTotalTimeTaken() async {
        await interactor?.getTotalTimeTaken()
    }
}

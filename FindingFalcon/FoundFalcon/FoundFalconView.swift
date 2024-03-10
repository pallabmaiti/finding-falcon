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
    var interactor: FoundFalconInteractor?
        
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
                .font(.headline)
                .multilineTextAlignment(.center)
            Text("Time taken: \(dataStore.totalTimeTaken)")
            Text("Planet found: \(dataStore.planetName ?? "")")
            startAgainButtonView
        }
    }
    
    private var failedView: some View {
        VStack {
            Text("Failed! King Shan is very angry.")
                .font(.headline)
            startAgainButtonView
        }
    }
    
    private var startAgainButtonView: some View {
        Button {
            startAgain()
            dismiss()
        } label: {
            Text("Start Again")
        }
        .buttonStyle(.bordered)
        .padding()
        .frame(height: 60)
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
    private func findFalcon() async {
        do {
            try await interactor?.findFalcon()
        } catch {
            
        }
    }
    
    private func startAgain() {
        interactor?.startAgain()
    }
    
    private func getTotalTimeTaken() async {
        await interactor?.getTotalTimeTaken()
    }
}

//
//  FindFalconeView.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 10/03/24.
//

import SwiftUI

protocol FindFalconeDisplayLogic {
    func displaySuccess(viewModel: FindFalcone.Find.ViewModelSuccess)
    func displayFailure(viewModel: FindFalcone.Find.ViewModelFailure)
    func displayTotalTimeTaken(viewModel: FindFalcone.TotalTimeTaken.ViewModel)
}

struct FindFalconeView: View {
    @Environment(\.dismiss) var dismiss
    var interactor: FindFalconeBusinessLogic?
        
    @ObservedObject private var dataStore = FindFalconeDataStore()

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
                await findFalcone()
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

extension FindFalconeView: FindFalconeDisplayLogic {
    func displaySuccess(viewModel: FindFalcone.Find.ViewModelSuccess) {
        dataStore.planetName = viewModel.planetName
        dataStore.isSuccess = true
    }
    
    func displayFailure(viewModel: FindFalcone.Find.ViewModelFailure) {
        dataStore.isSuccess = false
    }
    
    func displayTotalTimeTaken(viewModel: FindFalcone.TotalTimeTaken.ViewModel) {
        dataStore.totalTimeTaken = viewModel.totalTimeTaken
    }
}

extension FindFalconeView {
    func findFalcone() async {
        do {
            try await interactor?.findFalcone()
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

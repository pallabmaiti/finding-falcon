//
// FindFalconeDataStore.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 10/03/24.
//

import Foundation

final class FindFalconeDataStore: ObservableObject {
    @Published var planetName: String?
    @Published var isLoading = true
    @Published var isSuccess = false
    @Published var totalTimeTaken: Int = 0
}

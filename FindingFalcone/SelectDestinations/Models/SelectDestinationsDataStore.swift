//
//  SelectDestinationsDataStore
//  FindingFalcone
//
//  Created by Pallab Maiti on 05/03/24.
//

import Foundation

final class SelectDestinationsDataStore: ObservableObject {
    @Published var planetList: [Planet] = []
    @Published var vehicleList: [Vehicle] = []
    @Published var token: Token?
    @Published var isLoading = true
    
    required init(planetList: [Planet] = [], vehicleList: [Vehicle] = [], token: Token? = nil, isLoading: Bool = true) {
        self.planetList = planetList
        self.vehicleList = vehicleList
        self.token = token
        self.isLoading = isLoading
    }
}

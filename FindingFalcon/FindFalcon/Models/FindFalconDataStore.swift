//
//  FindFalconswift
//  FindingFalcon
//
//  Created by Pallab Maiti on 05/03/24.
//

import Foundation

final class FindFalconDataStore: ObservableObject {
    @Published var planetList: [Planet] = []
    @Published var vehicleList: [Vehicle] = []
    @Published var token: Token?
    @Published var isLoading = true
}

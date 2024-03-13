//
//  FindFalconswift
//  FindingFalcon
//
//  Created by Pallab Maiti on 05/03/24.
//

import Foundation

@Observable
final class FindFalconDataStore {
    var planetList: [Planet] = []
    var vehicleList: [Vehicle] = []
    var token: Token?
    var isLoading = true
}

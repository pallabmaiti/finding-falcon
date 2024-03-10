//
//  FindFalconswift
//  FindingFalcon
//
//  Created by Pallab Maiti on 05/03/24.
//

import Foundation
import Combine

final class FindFalconDataStore: ObservableObject {
    @Published var planetList1: [Planet] = []
    @Published var planetList2: [Planet] = []
    @Published var planetList3: [Planet] = []
    @Published var planetList4: [Planet] = []
    
    @Published var vehicleList1: [Vehicle] = []
    @Published var vehicleList2: [Vehicle] = []
    @Published var vehicleList3: [Vehicle] = []
    @Published var vehicleList4: [Vehicle] = []

    let vLPS1 = PassthroughSubject<[Vehicle], Never>()
    let vLPS2 = PassthroughSubject<[Vehicle], Never>()
    let vLPS3 = PassthroughSubject<[Vehicle], Never>()
    let vLPS4 = PassthroughSubject<[Vehicle], Never>()

    let pLPS1 = PassthroughSubject<[Planet], Never>()
    let pLPS2 = PassthroughSubject<[Planet], Never>()
    let pLPS3 = PassthroughSubject<[Planet], Never>()
    let pLPS4 = PassthroughSubject<[Planet], Never>()

    @Published var token: Token?
    
    @Published var isLoading = true
    @Published var selectedVehicle1: Vehicle?
    @Published var selectedVehicle2: Vehicle?
    @Published var selectedVehicle3: Vehicle?
    @Published var selectedVehicle4: Vehicle?
    
    @Published var selectedPlanet1: Planet?
    @Published var selectedPlanet2: Planet?
    @Published var selectedPlanet3: Planet?
    @Published var selectedPlanet4: Planet?
    
    @Published var t1: Int = 0
    @Published var t2: Int = 0
    @Published var t3: Int = 0
    @Published var t4: Int = 0
    
    var totalTimeTaken: Int {
        return t1 + t2 + t3 + t4
    }

    
    func reset() {
        planetList1 = planetList1.map{ Planet(name: $0.name, distance: $0.distance) }
        vehicleList1 = vehicleList1.map{ Vehicle(name: $0.name, totalNo: $0.totalNo, maxDistance: $0.maxDistance, speed: $0.speed) }
        
        planetList2 = []
        planetList3 = []
        planetList4 = []
        
        vehicleList2 = []
        vehicleList3 = []
        vehicleList4 = []
        
        selectedPlanet1 = nil
        selectedPlanet2 = nil
        selectedPlanet3 = nil
        selectedPlanet4 = nil
        selectedVehicle1 = nil
        selectedVehicle2 = nil
        selectedVehicle3 = nil
        selectedVehicle4 = nil
        
        t1 = 0
        t2 = 0
        t3 = 0
        t4 = 0
    }
    
    enum Destination {
        case one
        case two
        case three
        case four
    }
    
    func updateDestinationVehicleList(destination: Destination, list: [Vehicle]) {
        switch destination {
        case .one:
            vehicleList2 = list.map{ Vehicle(name: $0.name, totalNo: $0.totalNo, maxDistance: $0.maxDistance, speed: $0.speed) }
            vehicleList3 = []
            vehicleList4 = []
            selectedVehicle2 = nil
            selectedVehicle3 = nil
            selectedVehicle4 = nil
            if let sP = selectedPlanet1, let sV = selectedVehicle1 {
                t1 = sP.distance / sV.speed
            }
        case .two:
            vehicleList3 = list.map{ Vehicle(name: $0.name, totalNo: $0.totalNo, maxDistance: $0.maxDistance, speed: $0.speed) }
            vehicleList4 = []
            selectedVehicle3 = nil
            selectedVehicle4 = nil
            if let sP = selectedPlanet2, let sV = selectedVehicle2 {
                t2 = sP.distance / sV.speed
            }
        case .three:
            vehicleList4 = list.map{ Vehicle(name: $0.name, totalNo: $0.totalNo, maxDistance: $0.maxDistance, speed: $0.speed) }
            selectedVehicle4 = nil
            if let sP = selectedPlanet3, let sV = selectedVehicle3 {
                t3 = sP.distance / sV.speed
            }
        case .four:
            if let sP = selectedPlanet4, let sV = selectedVehicle4 {
                t4 = sP.distance / sV.speed
            }
        }
    }
    
    func updateDestinationPlanetList(destination: Destination, list: [Planet]) {
        switch destination {
        case .one:
            var pList = list.map{ Planet(name: $0.name, distance: $0.distance) }
            pList.removeAll(where: { $0.name == selectedPlanet1?.name })
            planetList2 = pList
            planetList3 = []
            planetList4 = []
            selectedPlanet2 = nil
            selectedPlanet3 = nil
            selectedPlanet4 = nil
        case .two:
            var pList = list.map{ Planet(name: $0.name, distance: $0.distance) }
            pList.removeAll(where: { $0.name == selectedPlanet2?.name })
            planetList3 = pList
            planetList4 = []
            selectedPlanet3 = nil
            selectedPlanet4 = nil
        case .three:
            var pList = list.map{ Planet(name: $0.name, distance: $0.distance) }
            pList.removeAll(where: { $0.name == selectedPlanet3?.name })
            planetList4 = pList
            selectedPlanet4 = nil
        case .four:
            break
        }
    }
}

//
// SelectDestinationsDataModel.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 13/03/24.
//

import Foundation

enum DestinationType {
    case one
    case two
    case three
    case four
}

final class Destination: ObservableObject, Identifiable {
    @Published var planetList: [Planet] = []
    @Published var vehicleList: [Vehicle] = []
    @Published var selectedVehicle: Vehicle?
    @Published var selectedPlanet: Planet?
    let id = UUID()
    
    var timeTaken: Int {
        guard let sP = selectedPlanet, let sV = selectedVehicle else {
            return 0
        }
        return sP.distance / sV.speed
    }
    
    let name: String
    
    required init(planetList: [Planet] = [], vehicleList: [Vehicle] = [], selectedVehicle: Vehicle? = nil, selectedPlanet: Planet? = nil, name: String) {
        self.planetList = planetList
        self.vehicleList = vehicleList
        self.selectedVehicle = selectedVehicle
        self.selectedPlanet = selectedPlanet
        self.name = name
    }
    
    func reset() {
        resetPlanet()
        resetVehicle()
    }
    
    func resetPlanet() {
        planetList = []
        selectedPlanet = nil
    }
    
    func resetVehicle() {
        vehicleList = []
        selectedVehicle = nil
    }
}

final class SelectDestinationsDataModel: ObservableObject {
    @Published var destinations: [Destination]
        
    var totalTimeTaken: Int {
        return destinations.map{ $0.timeTaken }.reduce(0) { $0 + $1 }
    }
    
    var shouldButtonDisabled: Bool {
        var count = 0
        while count < destinations.count {
            if (destinations[count].selectedVehicle == nil) {
                return true
            }
            count += 1
        }
        return false
    }
    
    required init(destinations: [Destination] = [
        Destination(name: "Destination 1"),
        Destination(name: "Destination 2"),
        Destination(name: "Destination 3"),
        Destination(name: "Destination 4")
    ]) {
        self.destinations = destinations
    }
    
    func reset() {
        destinations.forEach{ $0.reset() }
    }
    
    func updateNextDestinationVehicleList(destination: Destination) {
        if let index = destinations.firstIndex(where: { $0.id == destination.id }), index < (destinations.count - 1) {
            for i in (index + 1)..<destinations.count {
                destinations[i].resetVehicle()
            }
            let nextDestination = destinations[index + 1]
            nextDestination.vehicleList = destination.vehicleList.map{ Vehicle(
                name: $0.name,
                totalNo: ($0.name == destination.selectedVehicle?.name) ? ($0.totalNo - 1) : $0.totalNo,
                maxDistance: $0.maxDistance,
                speed: $0.speed
            ) }
            destinations[index + 1] = nextDestination
        }
    }
    
    func updateNextDestinationPlanetList(destination: Destination) {
        if let index = destinations.firstIndex(where: { $0.id == destination.id }), index < (destinations.count - 1) {
            for i in (index + 1)..<destinations.count {
                destinations[i].resetPlanet()
            }
            let nextDestination = destinations[index + 1]
            var pList = destination.planetList.map{ Planet(name: $0.name, distance: $0.distance) }
            pList.removeAll(where: { $0.name == destination.selectedPlanet?.name })
            nextDestination.planetList = pList
            destinations[index + 1] = nextDestination
        }
    }
}

//
//  FindFalconDataModel.swift
//  FindingFalcon
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

@Observable
final class Destination: Identifiable {
    var planetList: [Planet] = []
    var vehicleList: [Vehicle] = []
    var selectedVehicle: Vehicle?
    var selectedPlanet: Planet?
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

@Observable
final class FindFalconDataModel {
    var destinations: [Destination]
        
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
            destinations[index + 1].vehicleList = destination.vehicleList.map{ Vehicle(
                name: $0.name,
                totalNo: ($0.name == destination.selectedVehicle?.name) ? ($0.totalNo - 1) : $0.totalNo,
                maxDistance: $0.maxDistance,
                speed: $0.speed
            ) }
        }
    }
    
    func updateNextDestinationPlanetList(destination: Destination) {
        if let index = destinations.firstIndex(where: { $0.id == destination.id }), index < (destinations.count - 1) {
            for i in (index + 1)..<destinations.count {
                destinations[i].resetPlanet()
            }
            var pList = destination.planetList.map{ Planet(name: $0.name, distance: $0.distance) }
            pList.removeAll(where: { $0.name == destination.selectedPlanet?.name })
            destinations[index + 1].planetList = pList
        }
    }
}

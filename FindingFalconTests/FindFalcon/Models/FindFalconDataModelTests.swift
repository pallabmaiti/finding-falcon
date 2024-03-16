//
//  FindFalconDataModelTests.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcon

final class FindFalconDataModelTests: XCTestCase {
    func test_Destination() {
        let name: String = .mockAny()
        let planetList: [Planet] = [.mockAny()]
        let vehicleList: [Vehicle] = [.mockAny()]
        let destination = Destination(planetList: planetList, vehicleList: vehicleList, selectedVehicle: vehicleList.first, selectedPlanet: planetList.first, name: name)
        XCTAssertEqual(name, destination.name)
        XCTAssertEqual(planetList, destination.planetList)
        XCTAssertEqual(vehicleList, destination.vehicleList)
        XCTAssertEqual(planetList.first, destination.selectedPlanet)
        XCTAssertEqual(vehicleList.first, destination.selectedVehicle)
    }

    func test_Destination_Reset() {
        // Given
        let name: String = .mockAny()
        let planetList: [Planet] = [.mockAny()]
        let vehicleList: [Vehicle] = [.mockAny()]
        let destination = Destination(planetList: planetList, vehicleList: vehicleList, selectedVehicle: vehicleList.first, selectedPlanet: planetList.first, name: name)
        
        // When
        destination.reset()
        
        // Then
        XCTAssertEqual(name, destination.name)
        XCTAssertEqual(destination.planetList, [])
        XCTAssertEqual(destination.vehicleList, [])
        XCTAssertNil(destination.selectedPlanet)
        XCTAssertNil(destination.selectedVehicle)
    }
    
    func test_DataModel() {
        let planet1: Planet = .mockRandom(name: .mockRandom(), distance: 200)
        let planet2: Planet = .mockRandom(name: .mockRandom(), distance: 300)
        let planet3: Planet = .mockRandom(name: .mockRandom(), distance: 100)
        
        let planets: [Planet] = [planet1, planet2, planet3]
        
        let vehicle1: Vehicle = .mockRandom(name: .mockRandom(), totalNo: 2, maxDistance: 200, speed: 2)
        let vehicle2: Vehicle = .mockRandom(name: .mockRandom(), totalNo: 1, maxDistance: 300, speed: 2)
        let vehicle3: Vehicle = .mockRandom(name: .mockRandom(), totalNo: 1, maxDistance: 100, speed: 2)
        
        let vehicles: [Vehicle] = [vehicle1, vehicle2, vehicle3]
        
        let destination1: Destination = .mockRandom(name: .mockRandom(), planetList: [], vehicleList: [], selectedVehicle: nil, selectedPlanet: nil)
        let destination2: Destination = .mockRandom(name: .mockRandom(), planetList: [], vehicleList: [], selectedVehicle: nil, selectedPlanet: nil)
        let dataModel = FindFalconDataModel(destinations: [destination1, destination2])
        
        XCTAssertTrue(dataModel.shouldButtonDisabled)
        XCTAssertEqual(dataModel.totalTimeTaken, 0)
        XCTAssertEqual(destination1.planetList, [])
        XCTAssertEqual(destination1.vehicleList, [])
        XCTAssertEqual(destination2.planetList, [])
        XCTAssertEqual(destination2.vehicleList, [])
        
        dataModel.destinations.first?.planetList = planets
        dataModel.destinations.first?.vehicleList = vehicles
        
        XCTAssertEqual(destination1.planetList, planets)
        XCTAssertEqual(destination1.vehicleList, vehicles)
        XCTAssertEqual(destination2.planetList, [])
        XCTAssertEqual(destination2.vehicleList, [])
        
        destination1.selectedPlanet = planet2
        dataModel.updateNextDestinationPlanetList(destination: destination1)
        
        XCTAssertEqual(destination2.planetList, [planet1, planet3])
        
        destination1.selectedVehicle = vehicle2
        dataModel.updateNextDestinationVehicleList(destination: destination1)
        
        XCTAssertEqual(destination2.vehicleList[0], vehicle1)
        XCTAssertEqual(destination2.vehicleList[1].totalNo, 0)
        XCTAssertEqual(destination2.vehicleList[2], vehicle3)
        
        
        destination2.selectedPlanet = planet1
        destination2.selectedVehicle = vehicle1
        XCTAssertFalse(dataModel.shouldButtonDisabled)
        
        dataModel.reset()
        
        XCTAssertEqual(destination1.planetList, [])
        XCTAssertEqual(destination1.vehicleList, [])
        XCTAssertNil(destination1.selectedVehicle)
        XCTAssertNil(destination1.selectedPlanet)
        XCTAssertEqual(destination2.planetList, [])
        XCTAssertEqual(destination2.vehicleList, [])
        XCTAssertNil(destination2.selectedVehicle)
        XCTAssertNil(destination2.selectedPlanet)
    }
}

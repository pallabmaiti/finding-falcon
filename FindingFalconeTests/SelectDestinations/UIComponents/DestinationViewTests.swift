//
//  DestinationViewTests.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 16/03/24.
//

import XCTest
@testable import FindingFalcone

final class DestinationViewTests: XCTestCase {
    func test_Vehicle_Should_Not_Select_When_TotalNo_Zero() {
        let expectation = expectation(description: "Vehicle should not be selected")
        expectation.isInverted = true
        
        // Given
        let vehicle: Vehicle = .mockRandom(name: .mockRandom(), totalNo: 0, maxDistance: 200, speed: 2)
        let destination: Destination = .mockRandom(selectedVehicle: nil)

        let view = DestinationSelectionView(destination: destination, onVehicleSelect: expectation.fulfill)
        
        // When
        view.onSelectVehicle(vehicle)
        
        // Then
        XCTAssertNil(destination.selectedVehicle)
        
        waitForExpectations(timeout: 0.5)
    }
    
    func test_Vehicle_Should_Not_Select_When_Planet_Distance_Less_Than_Vehicle_MaxDistance() {
        let expectation = expectation(description: "Vehicle should not be selected")
        expectation.isInverted = true
        
        // Given
        let planet: Planet = .mockRandom(name: .mockRandom(), distance: 300)
        let vehicle: Vehicle = .mockRandom(name: .mockRandom(), totalNo: 1, maxDistance: 200, speed: 2)
        let destination: Destination = .mockRandom(selectedVehicle: nil, selectedPlanet: planet)
        
        let view = DestinationSelectionView(destination: destination, onVehicleSelect: expectation.fulfill)
        
        // When
        view.onSelectVehicle(vehicle)
        
        // Then
        XCTAssertNil(destination.selectedVehicle)

        waitForExpectations(timeout: 0.5)
    }
    
    func test_Vehicle_Should_Not_Select_When_It_Already_Selected() {
        let expectation = expectation(description: "Vehicle should not be selected")
        expectation.isInverted = true
        
        // Given
        let vehicle: Vehicle = .mockRandom(name: .mockRandom(), totalNo: 1, maxDistance: 200, speed: 2)
        let destination: Destination = .mockRandom(selectedVehicle: vehicle)
        
        let view = DestinationSelectionView(destination: destination, onVehicleSelect: expectation.fulfill)
        
        // When
        view.onSelectVehicle(vehicle)
        
        // Then
        XCTAssertNotNil(destination.selectedVehicle)

        waitForExpectations(timeout: 0.5)
    }
    
    func test_Vehicle_Should_be_Selected() {
        let expectation = expectation(description: "Vehicle should be selected")
        
        // Given
        let vehicle: Vehicle = .mockRandom(name: .mockRandom(), totalNo: 1, maxDistance: 200, speed: 2)
        let planet: Planet = .mockRandom(name: .mockRandom(), distance: 200)
        let destination: Destination = .mockRandom(selectedVehicle: nil, selectedPlanet: planet)
        
        let view = DestinationSelectionView(destination: destination, onVehicleSelect: expectation.fulfill)
        
        // When
        view.onSelectVehicle(vehicle)
        
        // Then
        XCTAssertEqual(destination.selectedVehicle, vehicle)

        waitForExpectations(timeout: 0.5)
    }
    
    func test_Planet_Should_be_Selected() {
        let expectation = expectation(description: "Planet should be selected")
        
        // Given
        let planet: Planet = .mockRandom(name: .mockRandom(), distance: 200)
        let destination: Destination = .mockRandom(selectedPlanet: nil)
        let view = DestinationSelectionView(destination: destination, onPlanetSelect: expectation.fulfill)
        
        // When
        view.onSelectPlanet(planet)
        
        // Then
        XCTAssertEqual(destination.selectedPlanet, planet)

        waitForExpectations(timeout: 0.5)
    }
}

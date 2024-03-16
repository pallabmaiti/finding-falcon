//
//  ModelMocks.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 13/03/24.
//

import Foundation
@testable import FindingFalcon

extension Planet: AnyMockable {
    public static func mockAny() -> Planet {
        return mockRandom()
    }
    
    static func mockRandom(
        name: String = .mockAny(),
        distance: Int = .mockAny()
    ) -> Planet {
        return Planet(name: name, distance: distance)
    }
}

extension Vehicle: AnyMockable {
    public static func mockAny() -> Vehicle {
        return mockRandom()
    }
    
    static func mockRandom(
        name: String = .mockAny(),
        totalNo: Int = .mockRandom(min: 1),
        maxDistance: Int = .mockAny(),
        speed: Int = .mockRandom(min: 50)
    ) -> Vehicle {
        return Vehicle(name: name, totalNo: totalNo, maxDistance: maxDistance, speed: speed)
    }
}

extension FindFalconDataModel: AnyMockable {
    public static func mockAny() -> Self {
        return mockRandom()
    }
    
    static func mockRandom(
        destinations: [Destination] = [.mockAny()]
    ) -> Self {
        return .init(destinations: destinations)
    }
}

extension Destination: AnyMockable {
    public static func mockAny() -> Self {
        return mockRandom()
    }
    
    static func mockRandom(
        name: String = .mockAny(),
        planetList: [Planet] = [.mockAny()],
        vehicleList: [Vehicle] = [.mockAny()],
        selectedVehicle: Vehicle? = .mockAny(),
        selectedPlanet: Planet? = .mockAny()
    ) -> Self {
        return .init(planetList: planetList, vehicleList: vehicleList, selectedVehicle: selectedVehicle, selectedPlanet: selectedPlanet, name: name)
    }
}

extension Token: AnyMockable {
    public static func mockAny() -> Token {
        return mockRandom()
    }
    
    static func mockRandom(
        token: String = .mockAny()
    ) -> Token {
        return Token(token: token)
    }
}

extension FindFalconDataStore: AnyMockable {
    public static func mockAny() -> Self {
        return mockRandom()
    }
    
    static func mockRandom(
        planetList: [Planet] = [.mockAny()],
        vehicleList: [Vehicle] = [.mockAny()],
        token: Token? = .mockAny(),
        isLoading: Bool = .mockAny()
    ) -> Self {
        return .init(planetList: planetList, vehicleList: vehicleList, token: token, isLoading: isLoading)
    }
}

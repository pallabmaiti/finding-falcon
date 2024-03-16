//
//  SelectDestinationsModelMocks.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcone

extension SelectDestinations.LoadVehicles.Response: AnyMockable {
    public static func mockAny() -> SelectDestinations.LoadVehicles.Response {
        return .mockRandom()
    }
    
    static func mockRandom(
        name: String = .mockAny(),
        totalNo: Int = .mockAny(),
        maxDistance: Int = .mockAny(),
        speed: Int = .mockAny()
    ) -> SelectDestinations.LoadVehicles.Response {
        return SelectDestinations.LoadVehicles.Response(
            name: name,
            totalNo: totalNo,
            maxDistance: maxDistance,
            speed: speed
        )
    }
}

extension SelectDestinations.LoadPlanets.Response: AnyMockable {
    public static func mockAny() -> SelectDestinations.LoadPlanets.Response {
        return mockRandom()
    }
    
    static func mockRandom(
        name: String = .mockAny(),
        distance: Int = .mockAny()
    ) -> SelectDestinations.LoadPlanets.Response {
        return SelectDestinations.LoadPlanets.Response(
            name: name,
            distance: distance
        )
    }
}

extension SelectDestinations.RetrieveToken.Response: AnyMockable {
    public static func mockAny() -> SelectDestinations.RetrieveToken.Response {
        return mockRandom()
    }
    
    static func mockRandom(
        token: String = .mockAny()
    ) -> SelectDestinations.RetrieveToken.Response {
        return SelectDestinations.RetrieveToken.Response(token: token)
    }
}

extension SelectDestinations.LoadPlanetsAndVehicles.Response: AnyMockable {
    public static func mockAny() -> SelectDestinations.LoadPlanetsAndVehicles.Response {
        return mockRandom()
    }
    
    static func mockRandom(
        planets: [SelectDestinations.LoadPlanets.Response] = [.mockAny()],
        vehicles: [SelectDestinations.LoadVehicles.Response] = [.mockAny()]
    ) -> SelectDestinations.LoadPlanetsAndVehicles.Response {
        return SelectDestinations.LoadPlanetsAndVehicles.Response(planets: planets, vehicles: vehicles)
    }
}

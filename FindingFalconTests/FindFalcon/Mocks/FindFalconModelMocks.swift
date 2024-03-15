//
//  FindFalconModelMocks.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcon

extension FindingFalcon.LoadVehicles.Response: AnyMockable {
    public static func mockAny() -> FindingFalcon.LoadVehicles.Response {
        return .mockRandom()
    }
    
    static func mockRandom(
        name: String = .mockAny(),
        totalNo: Int = .mockAny(),
        maxDistance: Int = .mockAny(),
        speed: Int = .mockAny()
    ) -> FindingFalcon.LoadVehicles.Response {
        return FindingFalcon.LoadVehicles.Response(
            name: name,
            totalNo: totalNo,
            maxDistance: maxDistance,
            speed: speed
        )
    }
}

extension FindingFalcon.LoadPlanets.Response: AnyMockable {
    public static func mockAny() -> FindingFalcon.LoadPlanets.Response {
        return mockRandom()
    }
    
    static func mockRandom(
        name: String = .mockAny(),
        distance: Int = .mockAny()
    ) -> FindingFalcon.LoadPlanets.Response {
        return FindingFalcon.LoadPlanets.Response(
            name: name,
            distance: distance
        )
    }
}

extension FindingFalcon.RetrieveToken.Response: AnyMockable {
    public static func mockAny() -> FindingFalcon.RetrieveToken.Response {
        return mockRandom()
    }
    
    static func mockRandom(
        token: String = .mockAny()
    ) -> FindingFalcon.RetrieveToken.Response {
        return FindingFalcon.RetrieveToken.Response(token: token)
    }
}

extension FindingFalcon.LoadPlanetsAndVehicles.Response: AnyMockable {
    public static func mockAny() -> FindingFalcon.LoadPlanetsAndVehicles.Response {
        return mockRandom()
    }
    
    static func mockRandom(
        planets: [FindingFalcon.LoadPlanets.Response] = [.mockAny()],
        vehicles: [FindingFalcon.LoadVehicles.Response] = [.mockAny()]
    ) -> FindingFalcon.LoadPlanetsAndVehicles.Response {
        return FindingFalcon.LoadPlanetsAndVehicles.Response(planets: planets, vehicles: vehicles)
    }
}

//
//  FindFalconeModelMocks.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcone

extension FindFalcone.Find.Response: AnyMockable {
    public static func mockAny() -> FindFalcone.Find.Response {
        return mockRandom()
    }
    
    static func mockRandom(
        planetName: String? = .mockAny(),
        status: String = .mockAny()
    ) -> FindFalcone.Find.Response {
        return FindFalcone.Find.Response(
            planetName: planetName,
            status: status
        )
    }
}

extension FindFalcone.Find.Request: AnyMockable {
    public static func mockAny() -> FindFalcone.Find.Request {
        return mockRandom()
    }
    
    static func mockRandom(
        token: String = .mockAny(),
        planetNames: [String] = [.mockAny()],
        vehicleNames: [String] = [.mockAny()]
    ) -> FindFalcone.Find.Request {
        return FindFalcone.Find.Request(token: token, planetNames: planetNames, vehicleNames: vehicleNames)
    }
}

extension FindFalcone.TotalTimeTaken.Response: AnyMockable {
    public static func mockAny() -> FindFalcone.TotalTimeTaken.Response {
        return mockRandom()
    }
    
    static func mockRandom(
        totalTimeTaken: Int = .mockAny()
    ) -> FindFalcone.TotalTimeTaken.Response {
        return FindFalcone.TotalTimeTaken.Response(totalTimeTaken: totalTimeTaken)
    }
}

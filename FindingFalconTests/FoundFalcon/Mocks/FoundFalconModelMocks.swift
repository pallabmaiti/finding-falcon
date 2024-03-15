//
//  FoundFalconModelMocks.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import Foundation
@testable import FindingFalcon

extension FoundFalcon.Find.Response: AnyMockable {
    public static func mockAny() -> FoundFalcon.Find.Response {
        return mockRandom()
    }
    
    static func mockRandom(
        planetName: String? = .mockAny(),
        status: String = .mockAny()
    ) -> FoundFalcon.Find.Response {
        return FoundFalcon.Find.Response(
            planetName: planetName,
            status: status
        )
    }
}

extension FoundFalcon.Find.Request: AnyMockable {
    public static func mockAny() -> FoundFalcon.Find.Request {
        return mockRandom()
    }
    
    static func mockRandom(
        token: String = .mockAny(),
        planetNames: [String] = [.mockAny()],
        vehicleNames: [String] = [.mockAny()]
    ) -> FoundFalcon.Find.Request {
        return FoundFalcon.Find.Request(token: token, planetNames: planetNames, vehicleNames: vehicleNames)
    }
}

extension FoundFalcon.TotalTimeTaken.Response: AnyMockable {
    public static func mockAny() -> FoundFalcon.TotalTimeTaken.Response {
        return mockRandom()
    }
    
    static func mockRandom(
        totalTimeTaken: Int = .mockAny()
    ) -> FoundFalcon.TotalTimeTaken.Response {
        return FoundFalcon.TotalTimeTaken.Response(totalTimeTaken: totalTimeTaken)
    }
}

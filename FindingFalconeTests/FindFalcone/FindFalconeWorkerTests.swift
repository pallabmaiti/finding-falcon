//
//  FindFalconeWorkerTests.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcone

final class FindFalconeWorkerTests: XCTestCase {
    func test_findFalcone() async throws {
        let value: FindFalcone.Find.Response = .mockAny()
        let networkManager = NetworkManagerMock(
            findFalconeResponse: APIResponse(
                value: value, needsRetry: false
            )
        )
        let worker = FindFalconeWorker(networkManager: networkManager)
        
        let response = try await worker.findFalcone(.mockAny())
        XCTAssertEqual(value, response)
    }
}

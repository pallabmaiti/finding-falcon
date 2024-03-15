//
//  FoundFalconWorkerTests.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcon

final class FoundFalconWorkerTests: XCTestCase {
    func test_findFalcon() async throws {
        let value: FoundFalcon.Find.Response = .mockAny()
        let networkManager = NetworkManagerMock(
            findFalconResponse: APIResponse(
                value: value, needsRetry: false
            )
        )
        let worker = FoundFalconWorker(networkManager: networkManager)
        
        let response = try await worker.findFalcon(.mockAny())
        XCTAssertEqual(value, response)
    }
}

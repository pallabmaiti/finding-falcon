//
//  FindFalconTokenWorkerTests.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcon

final class FindFalconTokenWorkerTests: XCTestCase {
    func test_retrieveToken() async throws {
        let retrieveTokenResponse: APIResponse<FindingFalcon.RetrieveToken.Response> = APIResponse(value: .mockAny(), needsRetry: false)
        let networkManager = NetworkManagerMock(retrieveTokenResponse: retrieveTokenResponse)
        
        let worker = FindFalconTokenWorker(networkManager: networkManager)
        
        let response = try await worker.retrieveToken()
        
        XCTAssertEqual(response.token, retrieveTokenResponse.value.token)
    }
}

//
//  URLSessionClientTests.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 14/03/24.
//

import XCTest
@testable import FindingFalcone

final class URLSessionClientTests: XCTestCase {
    
    func test_ReturnResponse() async throws {
        let server = ServerMock(serverResult: .success(response: .mockResponseWith(statusCode: 200)))
        let client = URLSessionClient(session: server.getInterceptedURLSession())
        
        let result = try await client.send(api: .mockAny())
        XCTAssertEqual(result.status, .success, "Client should return success")
    }
    
    func test_ReturnsError() async {
        let server = ServerMock(serverResult: .failure(error: NSError(domain: "Mock Error", code: 500)))
        let client = URLSessionClient(session: server.getInterceptedURLSession())
        
        do {
            _ = try await client.send(api: .mockAny())
            XCTFail()
        } catch {
            XCTAssertTrue(true, "Client should return failure")
        }
    }
}

extension API: AnyMockable {
    public static func mockAny() -> API {
        mockRandom()
    }
    
    static func mockRandom(
        number: Int = .mockAny()
    ) -> API {
        switch number % 4 {
        case 0:
            return .getPlanets
        case 1:
            return .getVehicles
        case 2:
            return .findFalcone(.mockAny())
        case 3:
            return .retrieveToken
        default:
            return .findFalcone(.mockAny())
        }
    }
}

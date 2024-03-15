//
//  NetworkManagerTests.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 13/03/24.
//

import XCTest
@testable import FindingFalcon

final class NetworkManagerTests: XCTestCase {
    func test_getVehicles_Success() async throws {
        let response: HTTPURLResponse = .mockResponseWith(statusCode: 200)
        let vehicleList: [FindingFalcon.LoadVehicles.Response] = [.mockAny(), .mockAny(), .mockAny()]
        let apiClient = APIClientMock(response: response, data: try? JSONEncoder().encode(vehicleList))
        let networkManager = NetworkManager(apiClient: apiClient, responseHandler: ResponseHandler())
        
        let expectedResponse = try await networkManager.getVehicles()

        XCTAssertEqual(vehicleList, expectedResponse.value, "Server returns vehicle list")
    }
    
    func test_getVehicles_Failure() async {
        let response: HTTPURLResponse = .mockResponseWith(statusCode: 500)
        let apiClient = APIClientMock(response: response)
        let networkManager = NetworkManager(apiClient: apiClient, responseHandler: ResponseHandler())
        
        do {
            _ = try await networkManager.getVehicles()
            XCTFail("Server should return error")
        } catch {
            XCTAssertTrue(true, "Server returns error")
        }
    }
    
    func test_getPlanets_Success() async throws {
        let response: HTTPURLResponse = .mockResponseWith(statusCode: 200)
        let planetList: [FindingFalcon.LoadPlanets.Response] = [.mockAny(), .mockAny(), .mockAny()]
        let apiClient = APIClientMock(response: response, data: try? JSONEncoder().encode(planetList))
        let networkManager = NetworkManager(apiClient: apiClient, responseHandler: ResponseHandler())
        
        let expectedResponse = try await networkManager.getPlanets()

        XCTAssertEqual(planetList, expectedResponse.value, "Server returns planet list")
    }
    
    func test_getPlanets_Failure() async {
        let response: HTTPURLResponse = .mockResponseWith(statusCode: 500)
        let apiClient = APIClientMock(response: response)
        let networkManager = NetworkManager(apiClient: apiClient, responseHandler: ResponseHandler())
        
        do {
            _ = try await networkManager.getPlanets()
            XCTFail("Server should return error")
        } catch {
            XCTAssertTrue(true, "Server returns error")
        }
    }
    
    func test_findFalcon_Success_it_returns_planetName() async throws {
        let response: HTTPURLResponse = .mockResponseWith(statusCode: 200)
        let findFalcon: FoundFalcon.Find.Response = .mockRandom(planetName: .mockAny(), status: "success")
        let apiClient = APIClientMock(response: response, data: try? JSONEncoder().encode(findFalcon))
        let networkManager = NetworkManager(apiClient: apiClient, responseHandler: ResponseHandler())
        
        let expectedResponse = try await networkManager.findFalcon(FoundFalcon.Find.Request(token: .mockAny(), planetNames: [.mockAny()], vehicleNames: [.mockAny()]))

        XCTAssertEqual(findFalcon, expectedResponse.value, "Falcon found")
    }
    
    func test_findFalcon_Success_it_doesn_not_return_planetName() async throws {
        let response: HTTPURLResponse = .mockResponseWith(statusCode: 200)
        let findFalcon: FoundFalcon.Find.Response = .mockRandom(planetName: nil, status: "false")
        let apiClient = APIClientMock(response: response, data: try? JSONEncoder().encode(findFalcon))
        let networkManager = NetworkManager(apiClient: apiClient, responseHandler: ResponseHandler())
        
        let expectedResponse = try await networkManager.findFalcon(FoundFalcon.Find.Request(token: .mockAny(), planetNames: [.mockAny()], vehicleNames: [.mockAny()]))

        XCTAssertEqual(findFalcon, expectedResponse.value, "Falcon not found")
    }
    
    func test_findFalcon_Failure() async {
        let response: HTTPURLResponse = .mockResponseWith(statusCode: 500)
        let apiClient = APIClientMock(response: response)
        let networkManager = NetworkManager(apiClient: apiClient, responseHandler: ResponseHandler())
        
        do {
            _ = try await networkManager.findFalcon(FoundFalcon.Find.Request(token: .mockAny(), planetNames: [.mockAny()], vehicleNames: [.mockAny()]))
            XCTFail("Server should return error")
        } catch {
            XCTAssertTrue(true, "Server returns error")
        }
    }
    
    func test_findFalcon_Failure_it_needs_retry() async {
        let response: HTTPURLResponse = .mockResponseWith(statusCode: 400)
        let apiClient = APIClientMock(response: response)
        let networkManager = NetworkManager(apiClient: apiClient, responseHandler: ResponseHandler())
        
        do {
            _ = try await networkManager.findFalcon(FoundFalcon.Find.Request(token: .mockAny(), planetNames: [.mockAny()], vehicleNames: [.mockAny()]))
            XCTFail("Server should return error")
        } catch {
            if let error: APIError = error as? APIError, case .noData(let result) = error {
                XCTAssertTrue(result.status.needsRetry, "Server should return 400")
            } else {
                XCTFail("Server should not return other error")
            }
        }
    }
    
    func test_retrieveToken_Success() async throws {
        let response: HTTPURLResponse = .mockResponseWith(statusCode: 200)
        let token: FindingFalcon.RetrieveToken.Response = .mockAny()
        let apiClient = APIClientMock(response: response, data: try? JSONEncoder().encode(token))
        let networkManager = NetworkManager(apiClient: apiClient, responseHandler: ResponseHandler())
        
        let expectedResponse = try await networkManager.retrieveToken()

        XCTAssertEqual(token, expectedResponse.value, "Server returns token")
    }
    
    func test_retrieveToken_Failure() async {
        let response: HTTPURLResponse = .mockResponseWith(statusCode: 500)
        let apiClient = APIClientMock(response: response)
        let networkManager = NetworkManager(apiClient: apiClient, responseHandler: ResponseHandler())
        
        do {
            _ = try await networkManager.retrieveToken()
            XCTFail("Server should not success")
        } catch {
            XCTAssertTrue(true, "Server should return error")
        }
    }
}

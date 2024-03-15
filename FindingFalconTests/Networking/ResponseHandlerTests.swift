//
//  ResponseHandlerTests.swift
//  FindingFalconTests
//
//  Created by Pallab Maiti on 14/03/24.
//

import XCTest
@testable import FindingFalcon

final class ResponseHandlerTests: XCTestCase {
    func test_parseData_Success() throws {
        let responseHandler = ResponseHandler()
        let testModel = TestModel(name: .mockAny())
        
        let expected: TestModel? = try responseHandler.parseData(try JSONEncoder().encode(testModel))
        
        XCTAssertEqual(testModel, expected)
    }
    
    func test_parseData_Failure() throws {
        let responseHandler = ResponseHandler(decoder: MockJSONDecoder())
        let testModel = TestModel(name: .mockAny())
        do {
            let _: TestModel? = try responseHandler.parseData(try JSONEncoder().encode(testModel))
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
    }
}

struct TestModel: Codable, Equatable {
    let name: String
}

enum TestJSONDecoderError: Error {
    case failedToParse
}

class MockJSONDecoder: JSONDecoder {
    override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        throw TestJSONDecoderError.failedToParse
    }
}

//
//  URLSessionTests.swift
//  MusiqNetworkTests
//
//  Created by Olivier Rigault on 20/05/2021.
//

import XCTest
import Combine
@testable import MusiqNetwork
@testable import MusiqCore

class URLSessionTests: XCTestCase {

    private var cancellable: AnyCancellable?

    override func tearDown() {
        cancellable?.cancel()
    }

    func testExecuteSuccessful() throws {
        
        let expectation = XCTestExpectation(description: "Successful")
        
        let jsonString = """
            {
                "message": "Hello, world!"
            }
            """

        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: jsonString)
        
        let session = URLSession.makeMockURLSession()
        
        cancellable = session.executeTest(request: URLRequest(url: URL(fileURLWithPath: "")))
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertEqual(response.message, "Hello, world!")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testExecuteMissingData() throws {
        
        let expectation = XCTestExpectation(description: "Failure: Missing data")
        
        let jsonString = """
            {
                "invalid_key": "value"
            }
            """

        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: jsonString)

        let session = URLSession.makeMockURLSession()
        
        cancellable = session.executeTest(request: URLRequest(url: URL(fileURLWithPath: "")))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    let expectedError = MusiqCore.DataError.parsing(description: "The data couldn’t be read because it is missing.")
                    XCTAssertEqual(error, expectedError)
                default:
                    XCTAssert(false, "Was expected an error, got a success instead")
                }
                
                expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 1)
    }

    func testExecuteInvalidData() throws {
        
        let expectation = XCTestExpectation(description: "Failure: invalid data")
        
        let jsonString = "Invalid json format"

        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: jsonString)

        let session = URLSession.makeMockURLSession()
        
        cancellable = session.executeTest(request: URLRequest(url: URL(fileURLWithPath: "")))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    let expectedError = MusiqCore.DataError.parsing(description: "The data couldn’t be read because it isn’t in the correct format.")
                    XCTAssertEqual(error, expectedError)
                default:
                    XCTAssert(false, "Was expected an error, got a success instead")
                }
                
                expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 1)
    }
}

struct URLSessionTestDTO: Decodable {
    let message: String
}

extension URLSession {
    
    func executeTest(request: URLRequest) -> AnyPublisher<URLSessionTestDTO, DataError> {
        return self.execute(request)
    }
}

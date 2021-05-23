//
//  DataRequesterTests.swift
//  MusiqNetworkTests
//
//  Created by Olivier Rigault on 23/05/2021.
//

import XCTest
import Combine
import Resolver
@testable import MusiqNetwork
@testable import MusiqCore

class DataRequesterTests: XCTestCase {

    private var cancellable: AnyCancellable?

    override func setUp() {
        Resolver.register { URLSession.makeMockURLSession() as URLSession }
    }
    
    override func tearDown() {
        cancellable?.cancel()
    }

    func testSuccesful() throws {
        
        let expectation = XCTestExpectation(description: "Failure: invalid data")
        let dataRequester = DataRequester()
        
        let jsonString = """
            {
                "message": "Hello, world!"
            }
            """

        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: jsonString)
        
        cancellable = dataRequester.loadTestData()
            .sink(receiveCompletion: { _ in  }) { response in
                XCTAssertEqual(response.message, "Hello, world!")
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 1)
    }

    func testInvalidURLComponents() throws {
        
        let expectation = XCTestExpectation(description: "Failure: invalid data")
        let dataRequester = DataRequester()
        
        cancellable = dataRequester.loadTestDataWithInvalidComponents()
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.network(description: "Couldn\'t create URL")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 1)
    }
}

struct DataRequesterTestDTO: Decodable {
    let message: String
}

extension DataRequester {
    
    func loadTestData() -> AnyPublisher<DataRequesterTestDTO, DataError> {
        return loadData(with: URLComponents())
    }
    
    func loadTestDataWithInvalidComponents() -> AnyPublisher<DataRequesterTestDTO, DataError> {
        
        // Build URLComponents with an invalid url
        // https://stackoverflow.com/questions/39852659/urlcomponents-url-is-nil
        var urlComponents = URLComponents(string: "http://google.com")!
        urlComponents.path = "auth/login"

        return loadData(with: urlComponents)
    }
}

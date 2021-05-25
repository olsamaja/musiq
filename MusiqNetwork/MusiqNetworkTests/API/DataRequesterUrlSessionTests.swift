//
//  DataRequesterUrlSessionTests.swift
//  MusiqNetworkTests
//
//  Created by Olivier Rigault on 25/05/2021.
//

import XCTest
import Combine
import Resolver
@testable import MusiqNetwork
@testable import MusiqCore

class DataRequesterUrlSessionTests: XCTestCase {

    private var cancellable: AnyCancellable?

    override func tearDown() {
        cancellable?.cancel()
    }

    func testMissingUrlSession() throws {
        
        let expectation = XCTestExpectation(description: "Failure: missing url session")
        let dataRequester = DataRequester()
        
        cancellable = dataRequester.loadTestData()
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.network(description: "Couldn\'t find a url session")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 3)
    }

}

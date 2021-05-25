//
//  MockURLProtocolTests.swift
//  MusiqNetworkTests
//
//  Created by Olivier Rigault on 26/05/2021.
//

import XCTest
@testable import MusiqConfiguration
@testable import MusiqNetwork

class MockURLProtocolTests: XCTestCase {

    func testMissingFile() throws {
        
        let handler = MockURLProtocol.makeRequestHandler(in: Bundle.main, with: "NonExistingFile")
        XCTAssertNil(handler)
    }

}

//
//  ApiDataNetworkConfigurationTests.swift
//  ApiDataNetworkConfigurationTests
//
//  Created by Olivier Rigault on 22/12/2020.
//

import XCTest
@testable import MusiqConfiguration

class ApiDataNetworkConfigurationTests: XCTestCase {

    func testConfiguration() throws {
        
        let bundle = Bundle(for: type(of: self))
        guard let configuration = ApiDataNetworkConfiguration(with: bundle) else {
            XCTFail("Unable to load initialise ApiDataNetworkConfiguration")
            return
        }
        
        XCTAssertEqual(configuration.scheme, .https)
        XCTAssertEqual(configuration.host, "www.thisisahost.com")
        XCTAssertEqual(configuration.path, "/thisisapath/")
        XCTAssertEqual(configuration.key, "thisisakey")
    }

}

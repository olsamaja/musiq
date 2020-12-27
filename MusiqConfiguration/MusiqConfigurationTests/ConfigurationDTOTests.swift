//
//  ConfigurationDTOTests.swift
//  MusiqConfigurationTests
//
//  Created by Olivier Rigault on 26/12/2020.
//

import XCTest
@testable import MusiqConfiguration

class ConfigurationDTOTests: XCTestCase {

    func testWithBundle() {
        
        let bundle = Bundle(for: type(of: self))
        let configuration = ConfigurationDTO(with: bundle)
        
        XCTAssertEqual(configuration.scheme, "https")
        XCTAssertEqual(configuration.host, "www.thisisahost.com")
        XCTAssertEqual(configuration.path, "/thisisapath/")
        XCTAssertEqual(configuration.key, "thisisakey")
    }

}

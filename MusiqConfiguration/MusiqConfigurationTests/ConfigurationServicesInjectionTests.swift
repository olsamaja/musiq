//
//  ConfigurationServicesInjectionTests.swift
//  MusiqConfigurationTests
//
//  Created by Olivier Rigault on 08/04/2021.
//

import XCTest
@testable import MusiqCore
@testable import MusiqConfiguration
@testable import Resolver

class ConfigurationServicesInjectionTests: XCTestCase {

    func testSuccessfulInjection() throws {
        
        Resolver.registerConfigurationServices(with: Bundle(for: type(of: self)))
        let configuration: Configuration = Resolver.resolve()
        
        XCTAssertNotNil(configuration)
        XCTAssertEqual(configuration.scheme, Configuration.Scheme.https)
        XCTAssertEqual(configuration.host, "www.thisisahost.com")
        XCTAssertEqual(configuration.path, "/thisisapath/")
        XCTAssertEqual(configuration.key, "thisisakey")
    }

}

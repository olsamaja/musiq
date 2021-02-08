//
//  ConfigurationDataProviderTests.swift
//  MusiqConfigurationTests
//
//  Created by Olivier Rigault on 27/12/2020.
//

import XCTest
@testable import MusiqConfiguration

class ConfigurationDataProviderTests: XCTestCase {

    func testWithBundle() throws {
        
        let bundle = Bundle(for: type(of: self))

        do {
            let configuration = try ConfigurationDataProvider.load(with: bundle)
            
            XCTAssertEqual(configuration.scheme, "https")
            XCTAssertEqual(configuration.host, "www.thisisahost.com")
            XCTAssertEqual(configuration.path, "/thisisapath/")
            XCTAssertEqual(configuration.key, "thisisakey")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}

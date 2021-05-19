//
//  URLComponentsBuilderTests.swift
//  MusiqNetworkTests
//
//  Created by Olivier Rigault on 19/05/2021.
//

import XCTest
import Resolver
@testable import MusiqConfiguration
@testable import MusiqNetwork

class URLComponentsBuilderTests: XCTestCase {

    func testExample() throws {
        
        let configuration = Configuration(scheme: Configuration.Scheme.https,
                                          host: "host",
                                          path: "path",
                                          key: "key")
        
        Resolver.register { configuration as Configuration }

        let urlComponents = URLComponentsBuilder()
            .with(key: "urlKey", value: "value")
            .build()
        
        XCTAssertEqual(urlComponents.scheme, Configuration.Scheme.https.rawValue)
        XCTAssertEqual(urlComponents.host, "host")
        XCTAssertEqual(urlComponents.path, "path")
        
        let queryItems = urlComponents.queryItems
        XCTAssertNotNil(queryItems)
        XCTAssertEqual(queryItems?.count, 3)
        
        XCTAssertEqual(queryItems![0].name, "urlKey")
        XCTAssertEqual(queryItems![0].value, "value")
        
        XCTAssertEqual(queryItems![1].name, "api_key")
        XCTAssertEqual(queryItems![1].value, "key")
        
        XCTAssertEqual(queryItems![2].name, "format")
        XCTAssertEqual(queryItems![2].value, "json")
    }

}

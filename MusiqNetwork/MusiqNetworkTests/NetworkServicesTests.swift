//
//  NetworkServicesTests.swift
//  MusiqNetworkTests
//
//  Created by Olivier Rigault on 25/05/2021.
//

import XCTest
import Resolver
@testable import MusiqNetwork
@testable import MusiqCore

class NetworkServicesTests: XCTestCase {

    override func setUpWithError() throws {
        Resolver.registerNetworkServices()
    }

    func testRegisteredUrlSession() throws {
        XCTAssertNotNil(NetworkServicesTestsHelper.session)
    }

}

struct NetworkServicesTestsHelper {
    
    @OptionalInjected static var session: URLSession?

}

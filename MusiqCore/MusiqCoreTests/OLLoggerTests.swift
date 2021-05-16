//
//  OLLoggerTests.swift
//  MusiqCoreTests
//
//  Created by Olivier Rigault on 16/05/2021.
//

import XCTest
@testable import MusiqCore

class OLLoggerTests: XCTestCase {

    func testConsole() throws {
        OLLogger.info("Test log with no bundle", with: nil)
        OLLogger.info("Test log with default bundle")
        XCTAssertTrue(true)
    }

}

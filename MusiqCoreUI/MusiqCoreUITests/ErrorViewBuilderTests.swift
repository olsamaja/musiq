//
//  ErrorViewBuilderTests.swift
//  MusiqCoreUITests
//
//  Created by Olivier Rigault on 26/03/2021.
//

import XCTest
@testable import MusiqCoreUI

class ErrorViewBuilderTests: XCTestCase {

    func testErrorViewBuilder() throws {
        
        let builderReference1 = ErrorViewBuilder()
        let builderReference2 = builderReference1
            .withSymbol("symbol")
            .withMessage("message")
        
        XCTAssertTrue(builderReference1 === builderReference2, "Expected references to be identical")
    }
}

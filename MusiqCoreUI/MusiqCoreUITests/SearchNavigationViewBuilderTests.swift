//
//  SearchNavigationViewBuilderTests.swift
//  MusiqCoreUITests
//
//  Created by Olivier Rigault on 27/03/2021.
//

import XCTest
@testable import MusiqCoreUI

class SearchNavigationViewBuilderTests: XCTestCase {

    func testSearchNavigationViewBuilder() throws {
        
        let builderReference1 = SearchNavigationViewBuilder()
        let builderReference2 = builderReference1
            .withTitle("title")
            .withPlaceholder("placeholder")
            .withUseLargeTitle(true)
            .onSearch({_ in })
            .onCancel({})

        XCTAssertTrue(builderReference1 === builderReference2, "Expected references to be identical")
    }
}

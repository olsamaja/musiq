//
//  SearchNavigationViewBuilderTests.swift
//  MusiqCoreUITests
//
//  Created by Olivier Rigault on 27/03/2021.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import MusiqCoreUI

extension SearchNavigationView: Inspectable {}

class SearchNavigationViewBuilderTests: XCTestCase {

    func testBuilderReferences() throws {
        
        let builderReference1 = SearchNavigationViewBuilder()
        let builderReference2 = builderReference1
            .withTitle("title")
            .withPlaceholder("placeholder")
            .withUseLargeTitle(true)
            .onSearch({_ in })
            .onCancel({})

        XCTAssertNotNil(builderReference2)
        XCTAssertTrue(builderReference1 === builderReference2, "Expected references to be identical")
    }
    
    func testPreviews() {
        
        let sut = SearchNavigationView_Previews.previews
                
        do {
            let group = try sut.inspect().group()
            XCTAssertEqual(group.count, 2)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

//
//  ArtistRowViewBuilderTests.swift
//  MusiqModuleArtistsTests
//
//  Created by Olivier Rigault on 10/04/2021.
//

import XCTest
@testable import MusiqModuleArtists

class ArtistRowViewBuilderTests: XCTestCase {

    func testBuilderReferences() throws {
        
        let builderReference1 = ArtistRowViewBuilder()
        let builderReference2 = builderReference1
            .withItem(ArtistRowItem(name: "Elvis"))

        XCTAssertNotNil(builderReference2)
        XCTAssertTrue(builderReference1 === builderReference2, "Expected references to be identical")
    }

}

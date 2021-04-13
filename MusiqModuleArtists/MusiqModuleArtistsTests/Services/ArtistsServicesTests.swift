//
//  ArtistsServicesTests.swift
//  MusiqModuleArtistsTests
//
//  Created by Olivier Rigault on 08/04/2021.
//

import XCTest
@testable import MusiqCore
@testable import MusiqModuleArtists
@testable import Resolver

class ArtistsServicesTests: XCTestCase {

    func testSuccessfulInjection() throws {
        
        Resolver.registerModuleArtistsServices()
        let viewModel: SearchArtistsViewModel = Resolver.resolve()
        
        XCTAssertNotNil(viewModel)
    }

}

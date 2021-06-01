//
//  ChartsServicesTests.swift
//  MusiqModuleChartsTests
//
//  Created by Olivier Rigault on 15/05/2021.
//

import XCTest
@testable import MusiqCore
@testable import MusiqModuleCharts
@testable import Resolver

class ArtistsServicesTests: XCTestCase {

    func testSuccessfulInjection() throws {
        
        Resolver.registerModuleChartsServices()
        let topTracksViewModel: ChartTopTracksViewModel = Resolver.resolve()
        let topArtistsViewModel: ChartTopArtistsViewModel = Resolver.resolve()
        let topTagsViewModel: ChartTopTagsViewModel = Resolver.resolve()

        XCTAssertNotNil(topTracksViewModel)
        XCTAssertNotNil(topArtistsViewModel)
        XCTAssertNotNil(topTagsViewModel)
    }

}

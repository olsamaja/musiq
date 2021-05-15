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
        let viewModel: ChartTopTracksViewModel = Resolver.resolve()
        
        XCTAssertNotNil(viewModel)
    }

}

//
//  ChartTopTracksViewModelTests.swift
//  MusiqModuleChartsTests
//
//  Created by Olivier Rigault on 15/05/2021.
//

import XCTest
@testable import MusiqCore
@testable import MusiqModuleCharts

class ChartTopTracksViewModelTests: XCTestCase {
    
    enum TestError: Error {
        case dummy
    }
    
    func testReduceIdle() throws {
        XCTAssertEqual(ChartTopTracksViewModel.reduce(.idle, .onAppear), .loading)
        XCTAssertEqual(ChartTopTracksViewModel.reduce(.idle, .onDataLoaded([])), .idle)
        XCTAssertEqual(ChartTopTracksViewModel.reduce(.idle, .onFailedToLoadData(TestError.dummy)), .idle)
    }

    func testReduceError() throws {
        let errorState = ChartTopTracksViewModel.State.error(TestError.dummy)
        XCTAssertEqual(ChartTopTracksViewModel.reduce(errorState, .onAppear), errorState)
    }

    func testReduceLoaded() throws {
        XCTAssertEqual(ChartTopTracksViewModel.reduce(.loaded([]), .onAppear), .loaded([]))
    }

}

//
//  ArtistsViewModelTests.swift
//  MusiqModuleArtistsTests
//
//  Created by Olivier Rigault on 11/04/2021.
//

import XCTest
@testable import MusiqCore
@testable import MusiqModuleArtists

class ArtistsViewModelTests: XCTestCase {

    enum TestError: Error {
        case dummy
    }
    
    func testReduceIdle() throws {
        XCTAssertEqual(ArtistsViewModel.reduce(.idle, .onAppear), .idle)
        XCTAssertEqual(ArtistsViewModel.reduce(.idle, .onDataLoaded([])), .idle)
        XCTAssertEqual(ArtistsViewModel.reduce(.idle, .onFailedToLoadData(TestError.dummy)), .idle)
        XCTAssertEqual(ArtistsViewModel.reduce(.idle, .onPerform(.clear)), .idle)
        XCTAssertEqual(ArtistsViewModel.reduce(.idle,
                                               .onPerform(.select(Artist(name: "name", mbid: "mbid")))),
                       .idle)

        XCTAssertEqual(ArtistsViewModel.reduce(.idle, .onPerform(.search("term"))), .searching("term"))
    }
    
    func testReduceSearching() throws {
        XCTAssertEqual(ArtistsViewModel.reduce(.searching("term"), .onAppear), .searching("term"))
        XCTAssertEqual(ArtistsViewModel.reduce(.searching("term"),
                                               .onFailedToLoadData(TestError.dummy)),
                       ArtistsViewModel.State.error(TestError.dummy))
        XCTAssertEqual(ArtistsViewModel.reduce(.searching("term"),
                                               .onDataLoaded([])),
                       .loaded([]))
    }

    func testReduceError() throws {
        let errorState = ArtistsViewModel.State.error(TestError.dummy)
        XCTAssertEqual(ArtistsViewModel.reduce(errorState, .onAppear), errorState)
    }

    func testReduceLoaded() throws {
        XCTAssertEqual(ArtistsViewModel.reduce(.loaded([]), .onPerform(.clear)), .idle)
        XCTAssertEqual(ArtistsViewModel.reduce(.loaded([]), .onPerform(.search("term"))), .searching("term"))
        XCTAssertEqual(ArtistsViewModel.reduce(.loaded([]), .onAppear), .loaded([]))
    }

}

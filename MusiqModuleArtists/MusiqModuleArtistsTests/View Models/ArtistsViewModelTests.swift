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
        XCTAssertEqual(SearchArtistsViewModel.reduce(.idle, .onAppear), .idle)
        XCTAssertEqual(SearchArtistsViewModel.reduce(.idle, .onDataLoaded([])), .idle)
        XCTAssertEqual(SearchArtistsViewModel.reduce(.idle, .onFailedToLoadData(TestError.dummy)), .idle)
        XCTAssertEqual(SearchArtistsViewModel.reduce(.idle, .onPerform(.clear)), .idle)
        XCTAssertEqual(SearchArtistsViewModel.reduce(.idle,
                                               .onPerform(.select(Artist(name: "name", mbid: "mbid")))),
                       .idle)

        XCTAssertEqual(SearchArtistsViewModel.reduce(.idle, .onPerform(.search("term"))), .searching("term"))
    }
    
    func testReduceSearching() throws {
        XCTAssertEqual(SearchArtistsViewModel.reduce(.searching("term"), .onAppear), .searching("term"))
        XCTAssertEqual(SearchArtistsViewModel.reduce(.searching("term"),
                                               .onFailedToLoadData(TestError.dummy)),
                       SearchArtistsViewModel.State.error(TestError.dummy))
        XCTAssertEqual(SearchArtistsViewModel.reduce(.searching("term"),
                                               .onDataLoaded([])),
                       .loaded([]))
    }

    func testReduceError() throws {
        let errorState = SearchArtistsViewModel.State.error(TestError.dummy)
        XCTAssertEqual(SearchArtistsViewModel.reduce(errorState, .onAppear), errorState)
    }

    func testReduceLoaded() throws {
        XCTAssertEqual(SearchArtistsViewModel.reduce(.loaded([]), .onPerform(.clear)), .idle)
        XCTAssertEqual(SearchArtistsViewModel.reduce(.loaded([]), .onPerform(.search("term"))), .searching("term"))
        XCTAssertEqual(SearchArtistsViewModel.reduce(.loaded([]), .onAppear), .loaded([]))
    }

}

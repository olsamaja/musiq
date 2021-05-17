//
//  ArtistsViewModelTests.swift
//  MusiqModuleArtistsTests
//
//  Created by Olivier Rigault on 11/04/2021.
//

import XCTest
import Combine
@testable import MusiqCore
@testable import MusiqModuleArtists

class ArtistsViewModelReduceTests: XCTestCase {

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

class ArtistsViewModelTests: XCTestCase {
    
    enum TestError: Error {
        case dummy
    }
    
    private var viewModel: SearchArtistsViewModel!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        viewModel = SearchArtistsViewModel(state: .idle)
    }
    
    override func tearDown() {
        cancellable?.cancel()
    }

    func testViewModel() {
        
        let expectation = XCTestExpectation(description: "Send event")
        
        _ = viewModel.$state.sink { state in
            XCTAssertEqual(state, .idle)
            expectation.fulfill()
        }
        
        viewModel.send(event: .onPerform(.search("Elvis")))
//        viewModel.clear()
        wait(for: [expectation], timeout: 1)
    }
}

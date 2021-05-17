//
//  ArtistsViewModelTests.swift
//  MusiqModuleArtistsTests
//
//  Created by Olivier Rigault on 11/04/2021.
//
//  Test a pubisher which never complete:
//  https://www.swiftbysundell.com/articles/unit-testing-combine-based-swift-code/
//

import XCTest
import Combine
import Resolver
@testable import MusiqCore
@testable import MusiqNetwork
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
    
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        Resolver.register { URLSession.makeMockURLSession() as URLSession }
        cancellables = []
    }

    func testSearch() {
        
        let expectation = XCTestExpectation(description: "Search event")
        let viewModel = SearchArtistsViewModel()

        let bundle = Bundle(for: type(of: self))
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(in: bundle, with: "MockSearchArtistsSuccessful")

        let expected = [
            SearchArtistsViewModel.State.idle,
            SearchArtistsViewModel.State.searching("Elvis"),
            SearchArtistsViewModel.State.loaded([])
        ]
        var states = [SearchArtistsViewModel.State]()

        viewModel.$state
            .sink { value in
                states.append(value)
                if states.count == expected.count {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.send(event: .onPerform(.search("Elvis")))
        wait(for: [expectation], timeout: 3)

        XCTAssertEqual(states, expected)
    }
}

//
//  SearchArtistsViewModel+ReduceTests.swift
//  MusiqAppTests
//
//  Created by Olivier Rigault on 06/02/2021.
//

import XCTest
@testable import MusiqApp
@testable import MusiqNetwork
@testable import MusiqModuleArtists

class SearchArtistsViewModel_ReduceTests: XCTestCase {

    enum TestError: Error {
        case dummy
    }
    
    let artist = Artist(name: "name", mbid: "mbid", url: nil, imageURL: nil, listeners: nil, playcount: nil)
    let error = TestError.dummy
    
    func testReduceIdle() throws {
        
        let state = SearchArtistsViewModel.State.idle
        let events: [SearchArtistsViewModel.Event] = [
            .onAppear,
            .onDataLoaded([]),
            .onFailedToLoadData(error),
            .onPerform(.clear),
            .onPerform(.select(artist))
        ]
        
        events.forEach { event in
            XCTAssertEqual(SearchArtistsViewModel.reduce(state, event), state)
         }
        
        XCTAssertEqual(SearchArtistsViewModel.reduce(state, .onPerform(.search("name"))), SearchArtistsViewModel.State.searching("name"))
    }

    func testReduceSearching() throws {
        
        let state = SearchArtistsViewModel.State.searching("name")
        let events: [SearchArtistsViewModel.Event] = [
            .onAppear,
            .onPerform(.clear),
            .onPerform(.search("name")),
            .onPerform(.select(artist))
        ]
        
        events.forEach { event in
            XCTAssertEqual(SearchArtistsViewModel.reduce(state, event), state)
         }
        
        XCTAssertEqual(SearchArtistsViewModel.reduce(state, .onDataLoaded([])), SearchArtistsViewModel.State.loaded([]))
        XCTAssertEqual(SearchArtistsViewModel.reduce(state, .onFailedToLoadData(error)), SearchArtistsViewModel.State.error(error))
    }
    
    func testReduceLoaded() throws {
        
        let state = SearchArtistsViewModel.State.loaded([])
        let events: [SearchArtistsViewModel.Event] = [
            .onAppear,
            .onDataLoaded([]),
            .onFailedToLoadData(error),
            .onPerform(.select(artist))
        ]
        
        events.forEach { event in
            XCTAssertEqual(SearchArtistsViewModel.reduce(state, event), state)
         }
        
        XCTAssertEqual(SearchArtistsViewModel.reduce(state, .onPerform(.search("name"))), SearchArtistsViewModel.State.searching("name"))
        XCTAssertEqual(SearchArtistsViewModel.reduce(state, .onPerform(.clear)), SearchArtistsViewModel.State.idle)
    }

    func testReduceError() throws {
        
        let state = SearchArtistsViewModel.State.error(error)
        let events: [SearchArtistsViewModel.Event] = [
            .onAppear,
            .onDataLoaded([]),
            .onFailedToLoadData(error),
            .onPerform(.clear),
            .onPerform(.search("name")),
            .onPerform(.select(artist))
        ]
        
        events.forEach { event in
            XCTAssertEqual(SearchArtistsViewModel.reduce(state, event), state)
         }
    }
}

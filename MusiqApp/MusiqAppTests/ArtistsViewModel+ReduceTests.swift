//
//  ArtistsViewModel+ReduceTests.swift
//  MusiqAppTests
//
//  Created by Olivier Rigault on 06/02/2021.
//

import XCTest
@testable import MusiqApp
@testable import MusiqNetwork
@testable import MusiqModuleArtists

class ArtistsViewModel_ReduceTests: XCTestCase {

    enum TestError: Error {
        case dummy
    }
    
    let artist = Artist(name: "name", mbid: "mbid", url: nil, imageURL: nil, listeners: nil, playcount: nil)
    let error = TestError.dummy
    
    func testReduceIdle() throws {
        
        let state = ArtistsViewModel.State.idle
        let events: [ArtistsViewModel.Event] = [
            .onAppear,
            .onDataLoaded([]),
            .onFailedToLoadData(error),
            .onPerform(.clear),
            .onPerform(.select(artist))
        ]
        
        events.forEach { event in
            XCTAssertEqual(ArtistsViewModel.reduce(state, event), state)
         }
        
        XCTAssertEqual(ArtistsViewModel.reduce(state, .onPerform(.search("name"))), ArtistsViewModel.State.searching("name"))
    }

    func testReduceSearching() throws {
        
        let state = ArtistsViewModel.State.searching("name")
        let events: [ArtistsViewModel.Event] = [
            .onAppear,
            .onPerform(.clear),
            .onPerform(.search("name")),
            .onPerform(.select(artist))
        ]
        
        events.forEach { event in
            XCTAssertEqual(ArtistsViewModel.reduce(state, event), state)
         }
        
        XCTAssertEqual(ArtistsViewModel.reduce(state, .onDataLoaded([])), ArtistsViewModel.State.loaded([]))
        XCTAssertEqual(ArtistsViewModel.reduce(state, .onFailedToLoadData(error)), ArtistsViewModel.State.error(error))
    }
    
    func testReduceLoaded() throws {
        
        let state = ArtistsViewModel.State.loaded([])
        let events: [ArtistsViewModel.Event] = [
            .onAppear,
            .onDataLoaded([]),
            .onFailedToLoadData(error),
            .onPerform(.select(artist))
        ]
        
        events.forEach { event in
            XCTAssertEqual(ArtistsViewModel.reduce(state, event), state)
         }
        
        XCTAssertEqual(ArtistsViewModel.reduce(state, .onPerform(.search("name"))), ArtistsViewModel.State.searching("name"))
        XCTAssertEqual(ArtistsViewModel.reduce(state, .onPerform(.clear)), ArtistsViewModel.State.idle)
    }

    func testReduceError() throws {
        
        let state = ArtistsViewModel.State.error(error)
        let events: [ArtistsViewModel.Event] = [
            .onAppear,
            .onDataLoaded([]),
            .onFailedToLoadData(error),
            .onPerform(.clear),
            .onPerform(.search("name")),
            .onPerform(.select(artist))
        ]
        
        events.forEach { event in
            XCTAssertEqual(ArtistsViewModel.reduce(state, event), state)
         }
    }
}

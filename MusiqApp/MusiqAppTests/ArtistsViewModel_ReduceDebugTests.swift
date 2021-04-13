//
//  ArtistsViewModel_ReduceDebugTests.swift
//  MusiqAppTests
//
//  Created by Olivier Rigault on 25/03/2021.
//

import XCTest
@testable import MusiqApp
@testable import MusiqNetwork
@testable import MusiqModuleArtists

class ArtistsViewModel_ReduceDebugTests: XCTestCase {

    enum TestError: Error {
        case dummy
    }
    
    func testDebugReduceStates() throws {
        XCTAssertEqual(SearchArtistsViewModel.State.idle.debugDescription, "State.idle")
        XCTAssertEqual(SearchArtistsViewModel.State.searching("term").debugDescription, "State.searching(term)")
        XCTAssertEqual(SearchArtistsViewModel.State.loaded([]).debugDescription, "State.loaded(0)")
        XCTAssertEqual(SearchArtistsViewModel.State.error(TestError.dummy).debugDescription, "State.error")
    }
    
    func testDebugReduceEvents() throws {
        XCTAssertEqual(SearchArtistsViewModel.Event.onAppear.debugDescription, "Event.onAppear")
        XCTAssertEqual(SearchArtistsViewModel.Event.onFailedToLoadData(TestError.dummy).debugDescription, "Event.error")
        XCTAssertEqual(SearchArtistsViewModel.Event.onDataLoaded([]).debugDescription, "Event.onDataLoaded(0)")
                
        let artist = Artist(name: "", mbid: "")
        let item = ArtistRowItem(artist: artist)
        let items = [item, item]
        XCTAssertEqual(SearchArtistsViewModel.Event.onDataLoaded(items).debugDescription, "Event.onDataLoaded(2)")
        XCTAssertEqual(SearchArtistsViewModel.Event.onDataLoaded([]).debugDescription, "Event.onDataLoaded(0)")
        
        XCTAssertEqual(SearchArtistsViewModel.Event.onPerform(SearchArtistsViewModel.Action.clear).debugDescription, "Event.onPerform(Action.clear)")
    }
    
    func testDebugReduceActions() throws {
        XCTAssertEqual(SearchArtistsViewModel.Action.clear.debugDescription, "Action.clear")
        XCTAssertEqual(SearchArtistsViewModel.Action.search("term").debugDescription, "Action.search(term)")
        
        let artist = Artist(name: "name", mbid: "")
        XCTAssertEqual(SearchArtistsViewModel.Action.select(artist).debugDescription, "Action.select(name)")
    }
}

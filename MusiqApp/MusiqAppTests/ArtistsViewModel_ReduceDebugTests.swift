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
        XCTAssertEqual(ArtistsViewModel.State.idle.debugDescription, "State.idle")
        XCTAssertEqual(ArtistsViewModel.State.searching("term").debugDescription, "State.searching(term)")
        XCTAssertEqual(ArtistsViewModel.State.loaded([]).debugDescription, "State.loaded(0)")
        XCTAssertEqual(ArtistsViewModel.State.error(TestError.dummy).debugDescription, "State.error")
    }
    
    func testDebugReduceEvents() throws {
        XCTAssertEqual(ArtistsViewModel.Event.onAppear.debugDescription, "Event.onAppear")
        XCTAssertEqual(ArtistsViewModel.Event.onFailedToLoadData(TestError.dummy).debugDescription, "Event.error")
        XCTAssertEqual(ArtistsViewModel.Event.onDataLoaded([]).debugDescription, "Event.onDataLoaded(0)")
                
        let artist = Artist(name: "", mbid: "")
        let item = ArtistRowItem(artist: artist)
        let items = [item, item]
        XCTAssertEqual(ArtistsViewModel.Event.onDataLoaded(items).debugDescription, "Event.onDataLoaded(2)")
        XCTAssertEqual(ArtistsViewModel.Event.onDataLoaded([]).debugDescription, "Event.onDataLoaded(0)")
        
        XCTAssertEqual(ArtistsViewModel.Event.onPerform(ArtistsViewModel.Action.clear).debugDescription, "Event.onPerform(Action.clear)")
    }
    
    func testDebugReduceActions() throws {
        XCTAssertEqual(ArtistsViewModel.Action.clear.debugDescription, "Action.clear")
        XCTAssertEqual(ArtistsViewModel.Action.search("term").debugDescription, "Action.search(term)")
        
        let artist = Artist(name: "name", mbid: "")
        XCTAssertEqual(ArtistsViewModel.Action.select(artist).debugDescription, "Action.select(name)")
    }
}

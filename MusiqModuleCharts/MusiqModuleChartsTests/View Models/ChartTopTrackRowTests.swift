//
//  ChartTopTrackRowViewTests.swift
//  MusiqModuleChartsTests
//
//  Created by Olivier Rigault on 15/05/2021.
//

import XCTest
@testable import MusiqModuleCharts

class ChartTopTrackRowTests: XCTestCase {
    
    func testWithParameters() throws {
        
        let item = ChartTopTrackRowItem(name: "My Way",
                                        artistName: "Franck Sinatra",
                                        listeners: "listeners",
                                        playcount: "playcount")
        XCTAssertEqual(item.name, "My Way")
        XCTAssertEqual(item.artistName, "Franck Sinatra")
        XCTAssertEqual(item.listeners, "listeners")
        XCTAssertEqual(item.playcount, "playcount")
    }
    
    func testWithTrack() throws {
        
        let track = ChartTopTrack(name: "My Way",
                                  artistName: "Franck Sinatra",
                                  listeners: "listeners",
                                  playcount: "playcount")
        let item = ChartTopTrackRowItem(track: track)
        XCTAssertEqual(item.name, "My Way")
        XCTAssertEqual(item.artistName, "Franck Sinatra")
        XCTAssertEqual(item.listeners, "listeners")
        XCTAssertEqual(item.playcount, "playcount")
    }

}

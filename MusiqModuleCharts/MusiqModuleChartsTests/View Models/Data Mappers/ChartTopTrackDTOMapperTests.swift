//
//  ChartTopTrackDTOMapperTests.swift
//  MusiqModuleChartsTests
//
//  Created by Olivier Rigault on 16/05/2021.
//

import XCTest
@testable import MusiqModuleCharts

class ChartTopTrackDTOMapperTests: XCTestCase {

    func testSuccessfulMapper() throws {
        
        let name = "My Way"
        let artist = "Frank Sinatra"
        let listeners = "1234"
        let playcount = "5678"
        
        let artistDTO = ChartArtistDTO(name: artist)
        let dto = ChartTopTrackDTO(name: name, artist: artistDTO, listeners: listeners, playcount: playcount)
        let track = ChartTopTrackDTOMapper.map(dto)

        XCTAssertEqual(track.name, name)
        XCTAssertEqual(track.artistName, artist)
        XCTAssertEqual(track.listeners, listeners)
        XCTAssertEqual(track.playcount, playcount)
    }

}

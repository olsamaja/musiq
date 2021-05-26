//
//  ArtistDTOMapperTests.swift
//  MusiqModuleArtistsTests
//
//  Created by Olivier Rigault on 26/05/2021.
//

import XCTest
@testable import MusiqModuleArtists
@testable import MusiqCore

class ArtistDTOMapperTests: XCTestCase {

    func testSuccessfulMapper() throws {
        
        let name = "name"
        let mbid = "mbid"
        let listeners = "listeners"
        let playcount = "playcount"
        
        let dto = ArtistDTO(name: name, mbid: mbid, url: nil, imageURL: nil, listeners: listeners, playcount: playcount, bio: nil)

        let artist = ArtistDTOMapper.map(dto)
        XCTAssertEqual(artist.name, name)
        XCTAssertEqual(artist.mbid, mbid)
        XCTAssertEqual(artist.listeners, listeners)
        XCTAssertEqual(artist.playcount, playcount)
    }

}

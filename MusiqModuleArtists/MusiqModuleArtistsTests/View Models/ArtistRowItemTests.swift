//
//  ArtistRowItemTests.swift
//  MusiqModuleArtistsTests
//
//  Created by Olivier Rigault on 08/04/2021.
//

import XCTest
@testable import MusiqCore
@testable import MusiqModuleArtists

class ArtistRowItemTests: XCTestCase {

    func testNameOnly() throws {
        
        let item = ArtistRowItem(name: "Elvis Presley")
        XCTAssertEqual(item.name, "Elvis Presley")
        XCTAssertNil(item.listeners)
    }

    func testNameAndListners() throws {
        
        let item = ArtistRowItem(name: "Elvis Presley", listeners: "1234")
        XCTAssertEqual(item.name, "Elvis Presley")
        XCTAssertEqual(item.listeners, "1234")
    }

    func testWithArtist() throws {
        
        let artist = Artist(name: "Bob Dylan",
                            mbid: "1234-5678",
                            url: URL(string: "http://www.google.com")!,
                            imageURL: URL(string: "http://www.ibm.com")!,
                            listeners: "1234",
                            playcount: "5678")
        
        let item = ArtistRowItem(artist: artist)
        XCTAssertEqual(item.name, "Bob Dylan")
        XCTAssertEqual(item.listeners, "1234")
    }

}

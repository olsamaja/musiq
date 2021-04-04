//
//  DataRequesterTests.swift
//  MusiqSharedTests
//
//  Created by Olivier Rigault on 22/12/2020.
//
//  Example: https://www.wwt.com/article/testing-networking-code-with-combine

import XCTest
import Combine
@testable import MusiqShared
@testable import MusiqConfiguration
@testable import MusiqModuleArtists

final class DataRequesterTests: XCTestCase {
    
    var dataRequester: DataRequester!
    private var cancellable: AnyCancellable?

    override func setUp() {
        dataRequester = DataRequester(session: URLSession.makeMockURLSession())
    }
    
    override func tearDown() {
        cancellable?.cancel()
    }

    func testSearchArtistsWithString() {

        let jsonString = """
            {
                "results": {
                    "opensearch:itemsPerPage": "30",
                    "opensearch:startIndex": "0",
                    "opensearch:totalResults": "385",
                    "artistmatches": {
                        "artist": [{
                            "listeners": "2593020",
                            "streamable": "0",
                            "image": [{
                                    "#text": "https://lastfm.freetls.fastly.net/i/u/34s/2a96cbd8b46e442fc41c2b86b821562f.png",
                                    "size": "small"
                                },
                                {
                                    "#text": "https://lastfm.freetls.fastly.net/i/u/64s/2a96cbd8b46e442fc41c2b86b821562f.png",
                                    "size": "medium"
                                },
                                {
                                    "#text": "https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png",
                                    "size": "large"
                                },
                                {
                                    "#text": "https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png",
                                    "size": "extralarge"
                                },
                                {
                                    "#text": "https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png",
                                    "size": "mega"
                                }
                            ],
                            "name": "Elvis Presley",
                            "mbid": "01809552-4f87-45b0-afff-2c6f0730a3be",
                            "url": "https://www.last.fm/music/Elvis+Presley"
                        }]
                    },
                    "@attr": {
                        "for": "Elvis"
                    },
                    "opensearch:Query": {
                        "#text": "",
                        "startPage": "1",
                        "role": "request",
                        "searchTerms": "Elvis"
                    }
                }
            }
        """

        let expectation = XCTestExpectation(description: "Search Elvis with String")

        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: jsonString)
        
        cancellable = dataRequester.searchArtists(term: "Elvis")
            .sink(receiveCompletion: { _ in }) { response in
            let artists = response.results.artistMatches.artist
            XCTAssertTrue(artists.count == 1, "Expected 1 artist, but got \(artists.count) instead.")
            XCTAssertTrue(artists[0].listeners == "2593020", "Expected 2593020, but got \(String(describing: artists[0].listeners)) instead.")
            XCTAssertTrue(artists[0].name == "Elvis Presley", "Expected 'Elvis Presley', but got \(String(describing: artists[0].name)) instead.")
            XCTAssertTrue(artists[0].mbid == "01809552-4f87-45b0-afff-2c6f0730a3be", "Expected '01809552-4f87-45b0-afff-2c6f0730a3be', but got \(String(describing: artists[0].mbid)) instead.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testSearchArtists() {
        
        let bundle = Bundle(for: type(of: self))
        let expectation = XCTestExpectation(description: "Search Elvis with json file")
        
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(in: bundle, with: "MockSearchArtistsSuccessful")
        
        cancellable = dataRequester.searchArtists(term: "Elvis").sink(receiveCompletion: { _ in }) { response in
            let artists = response.results.artistMatches.artist
            XCTAssertTrue(artists.count == 30, "Expected 30 artists, but got \(artists.count) instead.")
            XCTAssertTrue(artists[2].listeners == "529665", "Expected 529665, but got \(String(describing: artists[2].listeners)) instead.")
            XCTAssertTrue(artists[2].name == "Elvis Costello & The Attractions", "Expected 'Elvis Costello & The Attractions', but got \(String(describing: artists[2].name)) instead.")
            XCTAssertTrue(artists[2].mbid == "8a338e06-d182-46f2-bd16-30a09bc840ba", "Expected '8a338e06-d182-46f2-bd16-30a09bc840ba', but got \(String(describing: artists[2].mbid)) instead.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

}

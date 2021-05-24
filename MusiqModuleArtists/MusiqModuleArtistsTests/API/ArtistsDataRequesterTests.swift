//
//  DataRequesterTests.swift
//  MusiqSharedTests
//
//  Created by Olivier Rigault on 22/12/2020.
//
//  Example: https://www.wwt.com/article/testing-networking-code-with-combine

import XCTest
import Combine
import Resolver
@testable import MusiqNetwork
@testable import MusiqConfiguration
@testable import MusiqModuleArtists
@testable import MusiqCore

final class ArtistsDataRequesterTests: XCTestCase {
    
    var dataRequester: DataRequester!
    private var cancellable: AnyCancellable?

    override func setUp() {
        Resolver.register { URLSession.makeMockURLSession() as URLSession }
        dataRequester = DataRequester()
    }
    
    override func tearDown() {
        cancellable?.cancel()
    }
    
    enum Constants {
        static let jsonString = """
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
    }

    func testSearchArtistsWithString() {

        let expectation = XCTestExpectation(description: "Search Elvis with String")

        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: Constants.jsonString)
        
        cancellable = dataRequester.searchArtists(term: "Elvis")
            .sink(receiveCompletion: { _ in }) { response in
            let artists = response.results.artistMatches.artist
            XCTAssertEqual(artists.count, 1)
            XCTAssertEqual(artists[0].listeners, "2593020")
            XCTAssertEqual(artists[0].name, "Elvis Presley")
            XCTAssertEqual(artists[0].mbid, "01809552-4f87-45b0-afff-2c6f0730a3be")
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
            XCTAssertEqual(artists.count, 30)
            XCTAssertEqual(artists[2].listeners, "529665")
            XCTAssertEqual(artists[2].name, "Elvis Costello & The Attractions")
            XCTAssertEqual(artists[2].mbid, "8a338e06-d182-46f2-bd16-30a09bc840ba")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchFailWithInvalidFormat() {
        
        let expectation = XCTestExpectation(description: "Search with invalid format")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "Invalid")
        
        cancellable = dataRequester.searchArtists(term: "Elvis")
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it isn’t in the correct format.")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchFailWithMissingData() {
        
        let expectation = XCTestExpectation(description: "Search with missing data")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "{}")
        
        cancellable = dataRequester.searchArtists(term: "Elvis")
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it is missing.")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchFailWithInvalidRequest() {
        
        let expectation = XCTestExpectation(description: "Search with invalid request")
        MockURLProtocol.requestHandler = MockURLProtocol.makeInvalidRequestHandler()
        
        cancellable = dataRequester.searchArtists(term: "Elvis")
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.network(description: "The operation couldn’t be completed. (NSURLErrorDomain error -1.)")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
    
}

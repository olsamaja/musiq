//
//  ArtistDTOTests.swift
//  MusiqSharedTests
//
//  Created by Olivier Rigault on 29/12/2020.
//

import XCTest
import Combine
@testable import MusiqShared
@testable import MusiqCore

class ArtistDTOTests: XCTestCase {

    private var cancellable: AnyCancellable?

    override func tearDown() {
        cancellable?.cancel()
    }

    func testArtistDTOSuccessful() throws {

        let jsonString = """
            {
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
            }
        """
        
        let expectation = XCTestExpectation(description: "Decoding ArtistDTO")
        
        cancellable = parseData(with: jsonString)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in })
            { artist in
                XCTAssertTrue(artist.listeners == "2593020", "Expected 2593020, but got \(String(describing: artist.listeners)) instead.")
                XCTAssertTrue(artist.name == "Elvis Presley", "Expected 'Elvis Presley', but got \(String(describing: artist.name)) instead.")
                XCTAssertTrue(artist.mbid == "01809552-4f87-45b0-afff-2c6f0730a3be", "Expected '01809552-4f87-45b0-afff-2c6f0730a3be', but got \(String(describing: artist.mbid)) instead.")
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }

    private func parseData(with jsonString: String) -> AnyPublisher<ArtistDTO, DataError> {
        return Data(jsonString.utf8).decode()
    }
}


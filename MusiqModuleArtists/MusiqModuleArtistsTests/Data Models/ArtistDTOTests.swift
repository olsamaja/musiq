//
//  ArtistDTOTests.swift
//  MusiqSharedTests
//
//  Created by Olivier Rigault on 29/12/2020.
//

import XCTest
import Combine
@testable import MusiqNetwork
@testable import MusiqModuleArtists
@testable import MusiqCore

class ArtistDTOTests: XCTestCase {

    private var cancellable: AnyCancellable?

    override func tearDown() {
        cancellable?.cancel()
    }
    
    enum Constants {
        static let jsonString = """
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
    }

    func testArtistDTOSuccessful() throws {

        let expectation = XCTestExpectation(description: "Decoding ArtistDTO")
        let publisher: AnyPublisher<ArtistDTO, DataError> = Constants.jsonString.parse()

        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in })
            { artist in
                XCTAssertEqual(artist.listeners, "2593020")
                XCTAssertEqual(artist.name, "Elvis Presley")
                XCTAssertEqual(artist.mbid, "01809552-4f87-45b0-afff-2c6f0730a3be")
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testArtistDTOInvalid() {
        let expectation = XCTestExpectation(description: "Decoding invalid ArtistDTO")
        let publisher: AnyPublisher<ArtistDTO, DataError> = "invalid dto".parse()

        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    let expectedError = MusiqCore.DataError.parsing(description: "The data couldn’t be read because it isn’t in the correct format.")
                    XCTAssertEqual(error, expectedError)
                default:
                    XCTAssert(false, "Was expected an error, got a success instead")
                }
                
                expectation.fulfill()
            })
            { _ in }
        
        wait(for: [expectation], timeout: 1)
    }

}

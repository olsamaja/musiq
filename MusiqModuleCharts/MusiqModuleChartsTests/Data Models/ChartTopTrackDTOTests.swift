//
//  ChartTopTrackDTOTests.swift
//  MusiqModuleChartsTests
//
//  Created by Olivier Rigault on 15/05/2021.
//

import XCTest
import Combine
@testable import MusiqNetwork
@testable import MusiqModuleCharts
@testable import MusiqCore

class ChartTopTrackDTOTests: XCTestCase {
    
    private var cancellable: AnyCancellable?

    override func tearDown() {
        cancellable?.cancel()
    }
    
    enum Constants {
        static let jsonString = """
            {
                "listeners": "233254",
                "url": "https://www.last.fm/music/Kali+Uchis/_/telepatía",
                "streamable": {
                    "#text": "0",
                    "fulltrack": "0"
                },
                "artist": {
                    "name": "Kali Uchis",
                    "mbid": "",
                    "url": "https://www.last.fm/music/Kali+Uchis"
                },
                "mbid": "",
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
                    }
                ],
                "duration": "0",
                "name": "telepatía",
                "playcount": "3078840"
            }
            """
    }

    func testTopTrackDTOSuccessful() throws {

        let expectation = XCTestExpectation(description: "Decoding TopTrackDTO")
        let publisher: AnyPublisher<ChartTopTrackDTO, DataError> = Constants.jsonString.parse()

        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in })
            { track in
                XCTAssertEqual(track.name, "telepatía")
                XCTAssertEqual(track.listeners, "233254")
                XCTAssertEqual(track.playcount, "3078840")
                XCTAssertEqual(track.artist.name, "Kali Uchis")
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testTopTrackDTOInvalid() {
        let expectation = XCTestExpectation(description: "Decoding invalid ChartTopTrackDTO")
        let publisher: AnyPublisher<ChartTopTrackDTO, DataError> = "invalid dto".parse()

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

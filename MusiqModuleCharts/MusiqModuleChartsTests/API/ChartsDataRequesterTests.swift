//
//  ChartsDataRequesterTests.swift
//  MusiqModuleChartsTests
//
//  Created by Olivier Rigault on 15/05/2021.
//

import XCTest
import Combine
import Resolver
@testable import MusiqNetwork
@testable import MusiqConfiguration
@testable import MusiqModuleCharts

class ChartsDataRequesterTests: XCTestCase {
    
    var dataRequester: DataRequester!
    private var cancellable: AnyCancellable?

    override func setUp() {
        Resolver.register { URLSession.makeMockURLSession() as URLSession }
        dataRequester = DataRequester()
    }
    
    override func tearDown() {
        cancellable?.cancel()
    }

    func testTopTracks() {
        
        let bundle = Bundle(for: type(of: self))
        let expectation = XCTestExpectation(description: "Get top tracks with json file")
        
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(in: bundle, with: "MockChartGetTopTracksSuccessful")
        
        cancellable = dataRequester.getTopTracks().sink(receiveCompletion: { _ in }) { response in
            let tracks = response.tracks.track
            XCTAssertEqual(tracks.count, 50)
            XCTAssertEqual(tracks[2].name, "telepatía")
            XCTAssertEqual(tracks[2].artist.name, "Kali Uchis")
            XCTAssertEqual(tracks[2].listeners, "233254")
            XCTAssertEqual(tracks[2].playcount, "3078840")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

}

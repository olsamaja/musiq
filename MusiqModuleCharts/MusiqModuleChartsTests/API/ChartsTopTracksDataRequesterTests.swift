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
@testable import MusiqCore

class ChartsTopTracksDataRequesterTests: XCTestCase {
    
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
        
        cancellable = dataRequester.getTopTracks()
            .sink(receiveCompletion: { _ in }) { response in
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
    
    func testSearchFailWithInvalidFormat() {
        
        let expectation = XCTestExpectation(description: "Search with invalid format")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "Invalid")
        
        cancellable = dataRequester.getTopTracks()
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it isn’t in the correct format.")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchFailWithMissingData() {
        
        let expectation = XCTestExpectation(description: "Search with missing data")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "{}")
        
        cancellable = dataRequester.getTopTracks()
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it is missing.")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchFailWithInvalidRequest() {
        
        let expectation = XCTestExpectation(description: "Search with invalid request")
        MockURLProtocol.requestHandler = MockURLProtocol.makeInvalidRequestHandler()
        
        cancellable = dataRequester.getTopTracks()
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.network(description: "The operation couldn’t be completed. (NSURLErrorDomain error -1.)")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }

}

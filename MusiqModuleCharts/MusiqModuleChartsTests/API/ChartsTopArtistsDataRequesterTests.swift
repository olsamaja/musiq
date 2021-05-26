//
//  ChartsTopArtistsDataRequesterTests.swift
//  MusiqModuleChartsTests
//
//  Created by Olivier Rigault on 26/05/2021.
//

import XCTest
import Combine
import Resolver
@testable import MusiqNetwork
@testable import MusiqConfiguration
@testable import MusiqModuleCharts
@testable import MusiqCore

class ChartsTopArtistsDataRequesterTests: XCTestCase {
    
    var dataRequester: DataRequester!
    private var cancellable: AnyCancellable?

    override func setUp() {
        Resolver.register { URLSession.makeMockURLSession() as URLSession }
        dataRequester = DataRequester()
    }
    
    override func tearDown() {
        cancellable?.cancel()
    }

    func testTopArtists() {
        
        let bundle = Bundle(for: type(of: self))
        let expectation = XCTestExpectation(description: "Get top artists with json file")
        
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(in: bundle, with: "MockChartGetTopArtistsSuccessful")
        
        cancellable = dataRequester.getTopArtists()
            .sink(receiveCompletion: { _ in }) { response in
                let artists = response.artists.artist
                XCTAssertEqual(artists.count, 2)
                XCTAssertEqual(artists[1].name, "Bob Dylan")
                XCTAssertEqual(artists[1].listeners, "12345")
                XCTAssertEqual(artists[1].playcount, "233254")
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchFailWithInvalidFormat() {
        
        let expectation = XCTestExpectation(description: "Search with invalid format")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "Invalid")
        
        cancellable = dataRequester.getTopArtists()
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it isn’t in the correct format.")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchFailWithMissingData() {
        
        let expectation = XCTestExpectation(description: "Search with missing data")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "{}")
        
        cancellable = dataRequester.getTopArtists()
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it is missing.")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchFailWithInvalidRequest() {
        
        let expectation = XCTestExpectation(description: "Search with invalid request")
        MockURLProtocol.requestHandler = MockURLProtocol.makeInvalidRequestHandler()
        
        cancellable = dataRequester.getTopArtists()
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.network(description: "The operation couldn’t be completed. (NSURLErrorDomain error -1.)")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }

}

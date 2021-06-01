//
//  ChartsTopTagsDataRequesterTests.swift
//  MusiqModuleChartsTests
//
//  Created by Olivier Rigault on 02/06/2021.
//

import XCTest
import Combine
import Resolver
@testable import MusiqNetwork
@testable import MusiqConfiguration
@testable import MusiqModuleCharts
@testable import MusiqCore

class ChartsTopTagsDataRequesterTests: XCTestCase {
    
    var dataRequester: DataRequester!
    private var cancellable: AnyCancellable?

    override func setUp() {
        Resolver.register { URLSession.makeMockURLSession() as URLSession }
        dataRequester = DataRequester()
    }
    
    override func tearDown() {
        cancellable?.cancel()
    }

    func testTopTags() {
        
        let bundle = Bundle(for: type(of: self))
        let expectation = XCTestExpectation(description: "Get top tags with json file")
        
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(in: bundle, with: "MockChartGetTopTagsSuccessful")
        
        cancellable = dataRequester.getTopTags()
            .sink(receiveCompletion: { _ in }) { response in
                let tags = response.tags.tag
                XCTAssertEqual(tags.count, 2)
                XCTAssertEqual(tags[1].name, "rock")
                XCTAssertEqual(tags[1].taggings, "1233254")
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchFailWithInvalidFormat() {
        
        let expectation = XCTestExpectation(description: "Search with invalid format")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "Invalid")
        
        cancellable = dataRequester.getTopTags()
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it isn’t in the correct format.")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchFailWithMissingData() {
        
        let expectation = XCTestExpectation(description: "Search with missing data")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "{}")
        
        cancellable = dataRequester.getTopTags()
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it is missing.")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchFailWithInvalidRequest() {
        
        let expectation = XCTestExpectation(description: "Search with invalid request")
        MockURLProtocol.requestHandler = MockURLProtocol.makeInvalidRequestHandler()
        
        cancellable = dataRequester.getTopTags()
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.network(description: "The operation couldn’t be completed. (NSURLErrorDomain error -1.)")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }

}

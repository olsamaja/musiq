//
//  ChartTopTagDTOTests.swift
//  MusiqModuleChartsTests
//
//  Created by Olivier Rigault on 03/06/2021.
//

import XCTest
import Combine
@testable import MusiqNetwork
@testable import MusiqModuleCharts
@testable import MusiqCore

class ChartTopTagDTOTests: XCTestCase {

    private var cancellable: AnyCancellable?

    override func tearDown() {
        cancellable?.cancel()
    }
    
    enum Constants {
        static let jsonString = """
            {
                "name": "rock",
                "taggings": "1233254"
            }
            """
    }

    func testTopTagDTOSuccessful() throws {

        let expectation = XCTestExpectation(description: "Decoding TopTagDTO")
        let publisher: AnyPublisher<ChartTopTagDTO, DataError> = Constants.jsonString.parse()

        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in })
            { tag in
                XCTAssertEqual(tag.name, "rock")
                XCTAssertEqual(tag.taggings, "1233254")
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testTopTagDTOInvalid() {
        let expectation = XCTestExpectation(description: "Decoding invalid ChartTopTagDTO")
        let publisher: AnyPublisher<ChartTopTagDTO, DataError> = "invalid dto".parse()

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

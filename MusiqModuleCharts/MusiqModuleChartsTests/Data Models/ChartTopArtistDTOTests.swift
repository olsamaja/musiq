//
//  ChartTopArtistDTOTests.swift
//  MusiqModuleChartsTests
//
//  Created by Olivier Rigault on 26/05/2021.
//

import XCTest
import Combine
@testable import MusiqNetwork
@testable import MusiqModuleCharts
@testable import MusiqCore

class ChartTopArtistDTOTests: XCTestCase {

    private var cancellable: AnyCancellable?

    override func tearDown() {
        cancellable?.cancel()
    }
    
    enum Constants {
        static let jsonString = """
            {
                "name": "Bob Dylan",
                "playcount": "233254",
                "listeners": "12345"
            }
            """
    }

    func testTopArtistDTOSuccessful() throws {

        let expectation = XCTestExpectation(description: "Decoding TopArtistDTO")
        let publisher: AnyPublisher<ChartTopArtistDTO, DataError> = Constants.jsonString.parse()

        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in })
            { artist in
                XCTAssertEqual(artist.name, "Bob Dylan")
                XCTAssertEqual(artist.playcount, "233254")
                XCTAssertEqual(artist.listeners, "12345")
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testTopArtistDTOInvalid() {
        let expectation = XCTestExpectation(description: "Decoding invalid ChartTopArtistDTO")
        let publisher: AnyPublisher<ChartTopArtistDTO, DataError> = "invalid dto".parse()

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

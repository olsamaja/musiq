//
//  ImageDTOTests.swift
//  MusiqSharedTests
//
//  Created by Olivier Rigault on 02/01/2021.
//

import XCTest
import Combine
@testable import MusiqNetwork
@testable import MusiqModuleArtists
@testable import MusiqCore

class ImageDTOTests: XCTestCase {

    private var cancellable: AnyCancellable?

    override func tearDown() {
        cancellable?.cancel()
    }

    func testImageDTOSuccessful() throws {

        let jsonString = """
        {
            "#text": "https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png",
            "size": "large"
        }
        """
        
        let expectation = XCTestExpectation(description: "Decoding ImageDTO")
        let publisher: AnyPublisher<ImageDTO, DataError> = jsonString.parse()

        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in })
            { image in
                XCTAssertEqual(image.size, "large")
                XCTAssertEqual(image.urlString,  "https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png")
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testImageDTOInvalid() {
        let expectation = XCTestExpectation(description: "Decoding invalid ImageDTO")
        let publisher: AnyPublisher<ImageDTO, DataError> = "invalid dto".parse()

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

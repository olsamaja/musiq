//
//  ImageDTOTests.swift
//  MusiqSharedTests
//
//  Created by Olivier Rigault on 02/01/2021.
//

import XCTest
import Combine
@testable import MusiqShared
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
        
        cancellable = parseData(with: jsonString)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in })
            { image in
                XCTAssertEqual(image.size, "large")
                XCTAssertEqual(image.urlString,  "https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png")
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }

    private func parseData(with jsonString: String) -> AnyPublisher<ImageDTO, DataError> {
        return Data(jsonString.utf8).decode()
    }
}


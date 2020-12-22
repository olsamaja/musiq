//
//  BundleExtensionsTests.swift
//  MusiqCoreTests
//
//  Created by Olivier Rigault on 21/12/2020.
//

import XCTest
@testable import MusiqCore

class BundleExtensionsTests: XCTestCase {

    func testLoadFileFromBundle() throws {
        
        let fileName = "prettySample"
        let fileExtension = "json"
        let bundle = Bundle(for: type(of: self))
        guard let contents = bundle.loadContents(of: fileName, ofType: fileExtension) else {
            XCTFail("Unable to load " + fileName + "." + fileExtension)
            return
        }
        
        let jsonString = """
        {
            "firstName": "Carl",
            "lastName": "Lewis"
        }
        """
        
        XCTAssertEqual(contents.trimmed(), jsonString)
    }

}

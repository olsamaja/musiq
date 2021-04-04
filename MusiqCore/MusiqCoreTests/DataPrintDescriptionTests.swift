//
//  DataExtensionsTests.swift
//  MusiqCoreTests
//
//  Created by Olivier Rigault on 22/12/2020.
//

import XCTest
@testable import MusiqCore

class DataPrintDescriptionTests: XCTestCase {

    private func jsonString(from fileName: String, ofType fileExtension: String) -> String? {
        let bundle = Bundle(for: type(of: self))
        guard let string = bundle.loadContents(of: fileName, ofType: fileExtension) else {
            XCTFail("Unable to load " + fileName + "." + fileExtension)
            return nil
        }
        
        return string
    }
    
    func testPrettyJSONString() throws {
        
        guard let uglyJSON = jsonString(from: "sample", ofType: "json") else {
            XCTFail("Unable to find sample.json file")
            return
        }
        
        guard let data = uglyJSON.data(using: .utf8) else {
            XCTFail("Unable to convert string to data")
            return
        }
        
        guard let pretty = data.prettyPrintedJSONString as String? else {
            XCTFail("Unable to convert NSString to String")
            return
        }

        let string = """
        {
          "firstName" : "Carl",
          "lastName" : "Lewis"
        }
        """
        XCTAssertEqual(string, pretty, "\(string)\n is not equal to \n")
    }
}

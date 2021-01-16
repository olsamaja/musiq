//
//  StringExtensionsTests.swift
//  MusiqCoreTests
//
//  Created by Olivier Rigault on 21/12/2020.
//

import XCTest
@testable import MusiqCore

class StringExtensionsTests: XCTestCase {

    func testTrimJSONString() throws {
        
        let string1 = """
        {
            "firstName": "Carl",
            "lastName": "Lewis"
        }
        """
        
        let string2 = """
        {
            "firstName": "Carl",
            "lastName": "Lewis"
        }
        
        """
        
        let string3 = """

        {
            "firstName": "Carl",
            "lastName": "Lewis"
        }
        
        """
        
        XCTAssertEqual(string1.trimmed(), string1)
        XCTAssertEqual(string2.trimmed(), string1)
        XCTAssertEqual(string3.trimmed(), string1)
    }

    func testTrimSimpleStrings() throws {
        XCTAssertEqual("".trimmed(), "")
        XCTAssertEqual("string".trimmed(), "string")
    }

    func testTrimNewLines() throws {
        XCTAssertEqual("\n".trimmed(), "")
        XCTAssertEqual("\n\n".trimmed(), "")
        XCTAssertEqual("\n \n".trimmed(), "")
        XCTAssertEqual(" \n \n ".trimmed(), "")
        XCTAssertEqual("\nstring\n".trimmed(), "string")
    }

    func testTrimWhiteSpaces() throws {
        XCTAssertEqual("".trimmed(), "")
        XCTAssertEqual("string".trimmed(), "string")
        XCTAssertEqual(" string ".trimmed(), "string")
        XCTAssertEqual(" str ing ".trimmed(), "str ing")
    }
}

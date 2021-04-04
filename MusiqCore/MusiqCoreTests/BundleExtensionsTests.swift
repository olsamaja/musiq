//
//  BundleExtensionsTests.swift
//  MusiqCoreTests
//
//  Created by Olivier Rigault on 21/12/2020.
//

import XCTest
@testable import MusiqCore

class BundleExtensionsTests: XCTestCase {

    var bundle: Bundle!
    
    override func setUp() {
        bundle = Bundle(for: type(of: self))
    }
    
    func testLoadFileFromBundle() throws {
        
        let fileName = "prettySample"
        let fileExtension = "json"
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
    
    func testLoadFileFromBundleFailed() throws {
        XCTAssertNil(bundle.loadContents(of: "inexistant", ofType: "file"))
    }
    
    func testInfoForValidKey() {
        
        let validKey = bundle.infoForKey("CFBundleInfoDictionaryVersion")
        XCTAssertEqual(validKey, "6.0")
    }
    
    func testInfoForInvalidKey() {
        
        let invalidKey = bundle.infoForKey("Invalid key")
        XCTAssertNil(invalidKey)
    }

}

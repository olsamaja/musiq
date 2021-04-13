//
//  SpinnerBuilderTests.swift
//  MusiqCoreUITests
//
//  Created by Olivier Rigault on 09/04/2021.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import MusiqCoreUI

class SpinnerBuilderTests: XCTestCase {
//
//    func testBuilderReferences() throws {
//        
//        let builderReference1 = SpinnerBuilder()
//        let builderReference2 = builderReference1
//            .withColor(.red)
//            .isAnimating(true)
//
//        XCTAssertNotNil(builderReference2)
//        XCTAssertTrue(builderReference1 === builderReference2, "Expected references to be identical")
//    }

    func testPreviews() throws {
        
        let sut = SpinnerBuilder_Previews.previews
                
        do {
            let group = try sut.inspect().group()
            XCTAssertEqual(group.count, 3)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}

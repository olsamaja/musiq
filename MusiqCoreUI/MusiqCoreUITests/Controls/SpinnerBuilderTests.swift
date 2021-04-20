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

//
//  SizeThatFitPreviewTests.swift
//  MusiqCoreUITests
//
//  Created by Olivier Rigault on 09/04/2021.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import MusiqCoreUI

extension SizeThatFitPreview: Inspectable {}

class SizeThatFitPreviewTests: XCTestCase {

    func testPadding() {
        
        let sut = EmptyView().modifier(SizeThatFitPreview(title: "title"))
        
        do {
            let modifier = try sut.inspect().emptyView().modifier(SizeThatFitPreview.self)
            let content = try modifier.viewModifierContent()
            XCTAssertTrue(try content.hasPadding())
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

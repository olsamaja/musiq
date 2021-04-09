//
//  ErrorViewBuilderTests.swift
//  MusiqCoreUITests
//
//  Created by Olivier Rigault on 26/03/2021.
//

import XCTest
import ViewInspector
@testable import MusiqCoreUI

extension ErrorView: Inspectable {}

class ErrorViewBuilderTests: XCTestCase {

    func testBuilderReferences() throws {
        
        let builderReference1 = ErrorViewBuilder()
        let builderReference2 = builderReference1
            .withSymbol("symbol")
            .withMessage("message")
        
        XCTAssertTrue(builderReference1 === builderReference2, "Expected references to be identical")
    }

    func testView() throws {
        
        let sut = ErrorViewBuilder()
            .withSymbol("symbol")
            .withMessage("message")
            .build() as! ErrorView
        
        do {
            let vStack = try sut.inspect().vStack()
            let imageFontSize = try vStack.image(0).font()?.size()
            XCTAssertEqual(imageFontSize, 56.0)

            let message = try vStack.text(1).string()
            XCTAssertEqual(message, "message")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testPreviews() {
        
        let sut = ErrorView_Previews.previews
                
        do {
            let group = try sut.inspect().group()
            XCTAssertEqual(group.count, 3)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

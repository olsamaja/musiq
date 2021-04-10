//
//  MessageViewBuilderTests.swift
//  MusiqCoreUITests
//
//  Created by Olivier Rigault on 26/03/2021.
//

import XCTest
import ViewInspector
@testable import MusiqCoreUI

extension MessageView: Inspectable {}

class MessageViewBuilderTests: XCTestCase {

    func testBuilderReferences() throws {
        
        let builderReference1 = MessageViewBuilder()
        let builderReference2 = builderReference1
            .withSymbol("symbol")
            .withMessage("message")
        
        XCTAssertTrue(builderReference1 === builderReference2, "Expected references to be identical")
    }

    func testView() throws {
        
        let sut = MessageViewBuilder()
            .withSymbol("symbol")
            .withMessage("message")
            .withAlignment(.top)
            .build() as! MessageView
        
        do {
            let vStack = try sut.inspect().vStack()
            let imageFontSize = try vStack.image(1).font()?.size()
            XCTAssertEqual(imageFontSize, 56.0)

            let message = try vStack.text(2).string()
            XCTAssertEqual(message, "message")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testBottomView() throws {
        
        let sut = MessageViewBuilder()
            .withMessage("message")
            .withAlignment(.bottom)
            .build() as! MessageView
        
        do {
            let vStack = try sut.inspect().vStack()
            _ = try vStack.spacer(0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testPreviews() {
        
        let sut = MessageViewBuilder_Previews.previews
                
        do {
            let group = try sut.inspect().group()
            XCTAssertEqual(group.count, 4)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

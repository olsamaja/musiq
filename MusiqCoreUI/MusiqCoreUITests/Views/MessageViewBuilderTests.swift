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

    func testTopView() throws {
        
        let sut = MessageViewBuilder()
            .withSymbol("symbol")
            .withMessage("message")
            .withAlignment(.top)
            .build() as! MessageView
        
        do {
            let vStack = try sut.inspect().vStack()
            XCTAssertNil(try? vStack.spacer(0), "Should not expect a spacer at the top")
            
            let imageFontSize = try vStack.image(1).font()?.size()
            XCTAssertEqual(imageFontSize, 56)

            let message = try vStack.text(2).string()
            XCTAssertEqual(message, "message")
            
            XCTAssertNotNil(try? vStack.spacer(3), "Should expect a spacer at the bottom")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testCenteredView() throws {
        
        let sut = MessageViewBuilder()
            .withSymbol("pencil")
            .withSymbolSize(80)
            .build() as! MessageView
        
        do {
            let vStack = try sut.inspect().vStack()
            XCTAssertNil(try? vStack.spacer(0), "Should not expect a spacer at the top")
            
            let imageFontSize = try vStack.image(1).font()?.size()
            XCTAssertEqual(imageFontSize, 80)
            
            XCTAssertNil(try? vStack.text(2), "Should not expect a text there")
            XCTAssertNil(try? vStack.spacer(3), "Should not expect a spacer at the bottom")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testBottomView() throws {
        
        let sut = MessageViewBuilder()
            .withMessage("Hello, world!")
            .withFont(.headline)
            .withAlignment(.bottom)
            .build() as! MessageView
        
        do {
            let vStack = try sut.inspect().vStack()
            XCTAssertNotNil(try? vStack.spacer(0), "Should expect a spacer at the top")
            XCTAssertNil(try? vStack.image(1), "Should not expect an image there")
            
            let text = try vStack.text(2)
            XCTAssertEqual(try text.attributes().font(), .headline)
            XCTAssertEqual(try text.string(), "Hello, world!")
            
            XCTAssertNil(try? vStack.spacer(3), "Should not expect a spacer at the bottom")
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

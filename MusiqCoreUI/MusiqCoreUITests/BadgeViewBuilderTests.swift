//
//  BadgeViewBuilderTests.swift
//  MusiqCoreUITests
//
//  Created by Olivier Rigault on 08/04/2021.
//

import XCTest
import ViewInspector
@testable import MusiqCoreUI

extension BadgeView: Inspectable {}

class BadgeViewBuilderTests: XCTestCase {

    func testBuilderReferences() throws {
        
        let builderReference1 = BadgeViewBuilder()
        let builderReference2 = builderReference1
            .withText("message")
        
        XCTAssertTrue(builderReference1 === builderReference2, "Expected references to be identical")
    }

    func testEmptyView() throws {
        
        let sut = BadgeViewBuilder()
            .build() as! BadgeView
        
        do {
            let emptyView = try sut.inspect().emptyView()
            XCTAssertNotNil(emptyView)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testBadgeView() throws {
        
        let sut = BadgeViewBuilder()
            .withText("message")
            .build() as! BadgeView
        
        do {
            let text = try sut.inspect().text().string()
            XCTAssertEqual(text, "message")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testPreviews() throws {
        
        let sut = BadgeView_Previews.previews
                
        do {
            let group = try sut.inspect().group()
            XCTAssertEqual(group.count, 3)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}

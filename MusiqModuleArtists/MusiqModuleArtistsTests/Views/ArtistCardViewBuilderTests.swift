//
//  ArtistRowViewBuilderTests.swift
//  MusiqModuleArtistsTests
//
//  Created by Olivier Rigault on 10/04/2021.
//

import XCTest
import ViewInspector
@testable import MusiqModuleArtists
@testable import MusiqCoreUI

extension ArtistRowView: Inspectable {}
extension BadgeView: Inspectable {}

class ArtistRowViewBuilderTests: XCTestCase {

    func testBuilderReferences() throws {
        
        let builderReference1 = ArtistRowViewBuilder()
        let builderReference2 = builderReference1
            .withItem(ArtistRowItem(name: "Elvis"))

        XCTAssertNotNil(builderReference2)
        XCTAssertTrue(builderReference1 === builderReference2, "Expected references to be identical")
    }

    func testEmptyView() throws {
        
        let sut = ArtistRowViewBuilder().build()
        
        do {
            _ = try sut.inspect().emptyView()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testViewWithNameAndListeners() throws {
        
        let sut = ArtistRowViewBuilder()
            .withItem(ArtistRowItem(name: "Elvis", listeners: "1234"))
            .build()
        
        do {
            let view = try sut.inspect().find(ArtistRowView.self)
            let vStack = try view.vStack()
            let hStack = try vStack.hStack(0)
            
            let name = try hStack.text(0).string()
            XCTAssertEqual(name, "Elvis")
            
            let spacer = try hStack.spacer(1).minLength()
            XCTAssertEqual(spacer, 10)
            
            _ = try hStack.find(BadgeView.self)
            
            _ = try vStack.divider(1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testPreviews() {
        
        let sut = ArtistRowViewBuilder_Previews.previews
                
        do {
            let group = try sut.inspect().group()
            XCTAssertEqual(group.count, 4)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}

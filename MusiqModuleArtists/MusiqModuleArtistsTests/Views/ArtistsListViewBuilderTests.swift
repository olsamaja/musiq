//
//  ArtistsListViewBuilderTests.swift
//  MusiqModuleArtistsTests
//
//  Created by Olivier Rigault on 10/04/2021.
//

import XCTest
import ViewInspector
@testable import MusiqModuleArtists
@testable import MusiqCoreUI

extension ArtistsListView: Inspectable {}

class ArtistsListViewBuilderTests: XCTestCase {

    func testBuilderReferences() throws {
        
        let builderReference1 = ArtistsListViewBuilder()
        let builderReference2 = builderReference1
            .withItems([])

        XCTAssertNotNil(builderReference2)
        XCTAssertTrue(builderReference1 === builderReference2, "Expected references to be identical")
    }

    func testEmptyView() throws {
        
        let sut = ArtistsListViewBuilder().build()
        
        do {
            _ = try sut.inspect().emptyView()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testLoadedView() throws {
        
        let sut = ArtistsListViewBuilder()
            .withItems([
                ArtistRowItem(name: "Elvis"),
                ArtistRowItem(name: "Bob Dylan", listeners: "123456"),
            ])
            .build()
        
        do {
            let view = try sut.inspect().find(ArtistsListView.self)
            let list = try view.list()
            _ = try list.forEach(0).find(ArtistRowView.self)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testPreviews() {
        
        let sut = ArtistsListView_Previews.previews
                
        do {
            _ = try sut.inspect().find(ArtistsListView.self)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}

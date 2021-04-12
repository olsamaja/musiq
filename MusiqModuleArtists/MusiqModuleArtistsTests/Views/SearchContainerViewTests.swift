//
//  SearchContainerViewTests.swift
//  MusiqModuleArtistsTests
//
//  Created by Olivier Rigault on 12/04/2021.
//

import XCTest
import ViewInspector
import Resolver
@testable import MusiqModuleArtists
@testable import MusiqCoreUI

extension SearchContainerView: Inspectable {}
extension SearchNavigationView: Inspectable {}

class SearchContainerViewTests: XCTestCase {

    override func setUpWithError() throws {
        Resolver.register { ArtistsViewModel() as ArtistsViewModel }
    }

    func testView() throws {
        
        let sut = SearchContainerView()
        
        do {
            let view = try sut.inspect().find(SearchContainerView.self)
            _ = try view.find(SearchNavigationView.self)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testPreviews() {
        
        let sut = SearchContainerView_Previews.previews
                
        do {
            let group = try sut.inspect().group()
            XCTAssertEqual(group.count, 1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}

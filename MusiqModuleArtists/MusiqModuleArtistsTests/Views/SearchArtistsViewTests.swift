//
//  SearchArtistsViewTests.swift
//  MusiqModuleArtistsTests
//
//  Created by Olivier Rigault on 12/04/2021.
//

import XCTest
import ViewInspector
import Resolver
@testable import MusiqModuleArtists
@testable import MusiqCoreUI

extension SearchArtistsView: Inspectable {}
extension SearchNavigationView: Inspectable {}

class SearchArtistsViewTests: XCTestCase {

    override func setUpWithError() throws {
        Resolver.register { ArtistsViewModel() as ArtistsViewModel }
    }

    func testView() throws {
        
        let sut = SearchArtistsView()
        
        do {
            let view = try sut.inspect().find(SearchArtistsView.self)
            _ = try view.find(SearchNavigationView.self)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testPreviews() {
        
        let sut = SearchArtistsView_Previews.previews
                
        do {
            let group = try sut.inspect().group()
            XCTAssertEqual(group.count, 1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}

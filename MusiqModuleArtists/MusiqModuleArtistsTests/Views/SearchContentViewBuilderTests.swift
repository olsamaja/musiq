//
//  SearchContentViewBuilderTests.swift
//  MusiqModuleArtistsTests
//
//  Created by Olivier Rigault on 10/04/2021.
//

import XCTest
import ViewInspector
@testable import MusiqModuleArtists
@testable import MusiqCoreUI

extension SearchContentView: Inspectable {}
extension Spinner: Inspectable {}
extension MessageView: Inspectable {}

class SearchContentViewBuilderTests: XCTestCase {

    func testBuilderReferences() throws {
        
        let builderReference1 = SearchContentViewBuilder()
        let builderReference2 = builderReference1
            .withViewModel(ArtistsViewModel())

        XCTAssertNotNil(builderReference2)
        XCTAssertTrue(builderReference1 === builderReference2, "Expected references to be identical")
    }

    func testEmptyView() throws {
        
        let sut = SearchContentViewBuilder().build()
        
        do {
            _ = try sut.inspect().emptyView()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testViewModelStateIdle() throws {
        
        let viewModel = ArtistsViewModel()
        let sut = SearchContentViewBuilder()
            .withViewModel(viewModel)
            .build()
        
        do {
            let view = try sut.inspect().find(SearchContentView.self)
            _ = try view.find(MessageView.self)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testViewModelStateError() throws {
        
        enum TestError: Error {
            case dummy
        }
        
        let viewModel = ArtistsViewModel(state: .error(TestError.dummy))
        let sut = SearchContentViewBuilder()
            .withViewModel(viewModel)
            .build()
        
        do {
            let view = try sut.inspect().find(SearchContentView.self)
            _ = try view.find(MessageView.self)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testViewModelStateSearching() throws {
        
        let viewModel = ArtistsViewModel(state: .searching("Elvis"))
        let sut = SearchContentViewBuilder()
            .withViewModel(viewModel)
            .build()
        
        do {
            let view = try sut.inspect().find(SearchContentView.self)
            _ = try view.find(Spinner.self)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testViewModelStateLoaded() throws {
        
        let viewModel = ArtistsViewModel(state: .loaded([]))
        let sut = SearchContentViewBuilder()
            .withViewModel(viewModel)
            .build()
        
        do {
            let view = try sut.inspect().find(SearchContentView.self)
            _ = try view.find(ArtistsListView.self)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testPreviews() {
        
        let sut = SearchContentViewBuilder_Previews.previews
                
        do {
            let group = try sut.inspect().group()
            XCTAssertEqual(group.count, 5)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}

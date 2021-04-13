//
//  SearchArtistsResultsViewBuilderTests.swift
//  MusiqModuleArtistsTests
//
//  Created by Olivier Rigault on 10/04/2021.
//

import XCTest
import ViewInspector
@testable import MusiqModuleArtists
@testable import MusiqCoreUI

extension SearchArtistsResultsView: Inspectable {}
extension Spinner: Inspectable {}
extension MessageView: Inspectable {}

class SearchArtistsResultsViewBuilderTests: XCTestCase {

    func testBuilderReferences() throws {
        
        let builderReference1 = SearchArtistsResultsViewBuilder()
        let builderReference2 = builderReference1
            .withViewModel(ArtistsViewModel())

        XCTAssertNotNil(builderReference2)
        XCTAssertTrue(builderReference1 === builderReference2, "Expected references to be identical")
    }

    func testEmptyView() throws {
        
        let sut = SearchArtistsResultsViewBuilder().build()
        
        do {
            _ = try sut.inspect().emptyView()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testViewModelStateIdle() throws {
        
        let viewModel = ArtistsViewModel()
        let sut = SearchArtistsResultsViewBuilder()
            .withViewModel(viewModel)
            .build()
        
        do {
            let view = try sut.inspect().find(SearchArtistsResultsView.self)
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
        let sut = SearchArtistsResultsViewBuilder()
            .withViewModel(viewModel)
            .build()
        
        do {
            let view = try sut.inspect().find(SearchArtistsResultsView.self)
            _ = try view.find(MessageView.self)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testViewModelStateSearching() throws {
        
        let viewModel = ArtistsViewModel(state: .searching("Elvis"))
        let sut = SearchArtistsResultsViewBuilder()
            .withViewModel(viewModel)
            .build()
        
        do {
            let view = try sut.inspect().find(SearchArtistsResultsView.self)
            _ = try view.find(Spinner.self)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testViewModelStateLoaded() throws {
        
        let viewModel = ArtistsViewModel(state: .loaded([]))
        let sut = SearchArtistsResultsViewBuilder()
            .withViewModel(viewModel)
            .build()
        
        do {
            let view = try sut.inspect().find(SearchArtistsResultsView.self)
            _ = try view.find(ArtistsListView.self)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testPreviews() {
        
        let sut = SearchArtistsResultsViewBuilder_Previews.previews
                
        do {
            let group = try sut.inspect().group()
            XCTAssertEqual(group.count, 5)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}

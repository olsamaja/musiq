//
//  SearchArtistsView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 21/03/2021.
//

import SwiftUI
import MusiqCoreUI
import Resolver

public struct SearchArtistsView: View {
    
    @Injected var viewModel: SearchArtistsViewModel
    
    public init() {}
    
    public var body: some View {
        SearchNavigationViewBuilder()
            .withContentView(AnyView(content))
            .withTitle("Artists")
            .withPlaceholder("Search artists")
            .onSearch { (searchTerm) in
                viewModel.search(with: searchTerm)
            }
            .build()
            .ignoresSafeArea()
    }
    
    private var content: some View {
        SearchArtistsResultsViewBuilder()
            .withViewModel(viewModel)
            .build()
    }
}

struct SearchArtistsView_Previews: PreviewProvider {
    
    enum TestError: Error {
        case dummy
    }
    
    enum Dependencies {
        static var registerIdleState = { () -> Bool in
            Resolver.register { SearchArtistsViewModel() as SearchArtistsViewModel }
            return true
        }
        static var registerErrorState = { () -> Bool in
            Resolver.register { SearchArtistsViewModel(state: .error(TestError.dummy)) as SearchArtistsViewModel }
            return true
        }
    }
    
    static var previews: some View {
        Group {
            if Dependencies.registerIdleState() {
                SearchArtistsView()
                    .previewDisplayName("default state = .idle")
            }
            if Dependencies.registerErrorState() {
                SearchArtistsView()
                    .previewDisplayName("state = .error")
            }
        }
    }
}

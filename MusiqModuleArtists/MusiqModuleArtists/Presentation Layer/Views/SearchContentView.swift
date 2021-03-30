//
//  SearchContentView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 21/03/2021.
//

import SwiftUI
import MusiqCoreUI
import Resolver

public struct SearchContentView: View {
    
    @Injected var viewModel: ArtistsViewModel
    
    public init() {}
    
    public var body: some View {
        SearchNavigationViewBuilder()
            .withView(AnyView(SearchView(viewModel: viewModel)))
            .withTitle("Search")
            .withPlaceholder("Search artists")
            .onSearch { (searchTerm) in
                viewModel.search(with: searchTerm)
            }
            .build()
            .ignoresSafeArea()
    }
}

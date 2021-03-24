//
//  SearchContentView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 21/03/2021.
//

import SwiftUI
import MusiqCoreUI
import Resolver

struct SearchContentView: View {
    
    @Injected var viewModel: ArtistsViewModel
    
    var body: some View {
        SearchNavigationView(
            view: AnyView(SearchView(viewModel: viewModel)),
            useLargeTitle: true,
            title: "Search",
            placeholder: "Search artists",
            onSearch: { (searchTerm) in
                viewModel.search(with: searchTerm)
            })
            .ignoresSafeArea()
    }
}

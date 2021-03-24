//
//  SearchContentView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 21/03/2021.
//

import SwiftUI
import MusiqCoreUI

struct SearchContentView: View {
    
    var viewModel: ArtistsViewModel
    
    var body: some View {
        SearchNavigationView(
            view: AnyView(SearchView(viewModel: viewModel)),
            useLargeTitle: true,
            title: "Search",
            placeholder: "Search artists",
            onSearch: { (searchTerm) in
                viewModel.search(with: searchTerm)
            },
            onCancel: {
                viewModel.clear()
             })
            . ignoresSafeArea()
    }
}

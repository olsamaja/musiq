//
//  SearchContainerView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 21/03/2021.
//

import SwiftUI
import MusiqCoreUI
import Resolver

public struct SearchContainerView: View {
    
    @Injected var viewModel: ArtistsViewModel
    
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
        SearchContentViewBuilder()
            .withViewModel(viewModel)
            .build()
    }
}

struct SearchContainerView_Previews: PreviewProvider {
    
    static var registerDependency = { () -> Bool in
        Resolver.register { ArtistsViewModel() as ArtistsViewModel }
        return true
    }
    
    static var previews: some View {
        if registerDependency() {
            Group {
                SearchContainerView()
            }
        }
    }
}

//
//  SearchArtistsResultsView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 21/03/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct SearchArtistsResultsView: View {
    
    @ObservedObject var viewModel: ArtistsViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            MessageViewBuilder()
                .withMessage("Search artists, for example, Elvis")
                .withAlignment(.top)
                .build()
        case .error(let error):
            MessageViewBuilder()
                .withSymbol("xmark.octagon")
                .withMessage(error.localizedDescription)
                .build()
        case .loaded(let artists):
            ArtistsListViewBuilder()
                .withItems(artists)
                .build()
        case .searching:
            SpinnerBuilder()
                .withStyle(.large)
                .isAnimating(true)
                .build()
        }
    }
}

public class SearchArtistsResultsViewBuilder: BuilderProtocol {
    
    private var viewModel: ArtistsViewModel?
    
    public func withViewModel(_ viewModel: ArtistsViewModel) -> SearchArtistsResultsViewBuilder {
        self.viewModel = viewModel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let viewModel = viewModel {
            SearchArtistsResultsView(viewModel: viewModel)
        } else {
            EmptyView()
        }
    }
}

struct SearchArtistsResultsViewBuilder_Previews: PreviewProvider {
    
    enum TestError: Error {
        case dummy
    }
    
    static var previews: some View {
        Group {
            SearchArtistsResultsViewBuilder()
                .withViewModel(ArtistsViewModel(state: .loaded([
                    ArtistRowItem(name: "Elvis"),
                    ArtistRowItem(name: "Bob Dylan", listeners: "123456"),
                    ArtistRowItem(name: "Bob Marley", listeners: "A huge number"),
                    ArtistRowItem(name: "A super very long name for an artist group", listeners: "123456"),
                    ArtistRowItem(name: "Lisa Marie Preley"),
                    ArtistRowItem(name: "Frank Sinatra", listeners: "123456"),
                    ArtistRowItem(name: "Elvis"),
                    ArtistRowItem(name: "Bob Dylan", listeners: "123456"),
                    ArtistRowItem(name: "Bob Marley", listeners: "A huge number"),
                    ArtistRowItem(name: "A super very long name for an artist group", listeners: "123456"),
                    ArtistRowItem(name: "Elvis"),
                    ArtistRowItem(name: "Bob Dylan", listeners: "123456"),
                    ArtistRowItem(name: "Bob Marley", listeners: "A huge number"),
                    ArtistRowItem(name: "A super very long name for an artist group", listeners: "123456")
                ])))
                .build()
                .previewDisplayName("state = .loaded")
            SearchArtistsResultsViewBuilder()
                .withViewModel(ArtistsViewModel())
                .build()
                .previewDisplayName("default state = .idle")
            SearchArtistsResultsViewBuilder()
                .withViewModel(ArtistsViewModel(state: .searching("Elvis")))
                .build()
                .previewDisplayName("state = .searching")
            SearchArtistsResultsViewBuilder()
                .withViewModel(ArtistsViewModel(state: .error(TestError.dummy)))
                .build()
                .previewDisplayName("state = .error")
            SearchArtistsResultsViewBuilder()
                .build()
                .previewDisplayName("No view model, so should not appear")
        }
    }
}

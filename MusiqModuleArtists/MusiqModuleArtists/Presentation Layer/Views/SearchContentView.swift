//
//  SearchContentView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 21/03/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct SearchContentView: View {
    
    @ObservedObject var viewModel: ArtistsViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            VStack {
                Text("Search artists, for example, Elvis")
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(.body)
                Spacer()
            }
        case .error(let error):
            ErrorViewBuilder()
                .withSymbol("xmark.octagon")
                .withMessage(error.localizedDescription)
                .build()
        case .loaded(let artists):
            ArtistsListViewBuilder()
                .withItems(artists)
                .build()
        case .searching:
            Spinner(isAnimating: true, style: .large)
        }
    }
}

public class SearchContentViewBuilder: BuilderProtocol {
    
    private var viewModel: ArtistsViewModel?
    
    public func withViewModel(_ viewModel: ArtistsViewModel) -> SearchContentViewBuilder {
        self.viewModel = viewModel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let viewModel = viewModel {
            SearchContentView(viewModel: viewModel)
        } else {
            EmptyView()
        }
    }
}

struct SearchContentView_Previews: PreviewProvider {
    
    enum TestError: Error {
        case dummy
    }
    
    static var previews: some View {
        Group {
            SearchContentViewBuilder()
                .withViewModel(ArtistsViewModel(state: .loaded([
                    ArtistCardItem(name: "Elvis"),
                    ArtistCardItem(name: "Bob Dylan", listeners: "123456"),
                    ArtistCardItem(name: "Bob Marley", listeners: "A huge number"),
                    ArtistCardItem(name: "A super very long name for an artist group", listeners: "123456"),
                    ArtistCardItem(name: "Lisa Marie Preley"),
                    ArtistCardItem(name: "Frank Sinatra", listeners: "123456"),
                    ArtistCardItem(name: "Elvis"),
                    ArtistCardItem(name: "Bob Dylan", listeners: "123456"),
                    ArtistCardItem(name: "Bob Marley", listeners: "A huge number"),
                    ArtistCardItem(name: "A super very long name for an artist group", listeners: "123456"),
                    ArtistCardItem(name: "Elvis"),
                    ArtistCardItem(name: "Bob Dylan", listeners: "123456"),
                    ArtistCardItem(name: "Bob Marley", listeners: "A huge number"),
                    ArtistCardItem(name: "A super very long name for an artist group", listeners: "123456")
                ])))
                .build()
                .previewDisplayName("state = .loaded")
            SearchContentViewBuilder()
                .withViewModel(ArtistsViewModel())
                .build()
                .previewDisplayName("default state = .idle")
            SearchContentViewBuilder()
                .withViewModel(ArtistsViewModel(state: .searching("Elvis")))
                .build()
                .previewDisplayName("state = .searching")
            SearchContentViewBuilder()
                .withViewModel(ArtistsViewModel(state: .error(TestError.dummy)))
                .build()
                .previewDisplayName("state = .error")
            SearchContentViewBuilder()
                .build()
                .previewDisplayName("No view model, so should not appear")
        }
    }
}

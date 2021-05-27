//
//  ChartTopArtistsResultsView.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 21/04/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct ChartTopArtistsResultsView: View {
    
    @ObservedObject var viewModel: ChartTopArtistsViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            MessageViewBuilder()
                .withMessage("Loading top artists")
                .withAlignment(.top)
                .build()
                .onAppear {
                    viewModel.send(event: .onAppear)
                }
        case .error(let error):
            MessageViewBuilder()
                .withSymbol("xmark.octagon")
                .withMessage(error.localizedDescription)
                .build()
        case .loaded(let artists):
            ChartTopArtistsListViewBuilder()
                .withItems(artists)
                .build()
        case .loading:
            SpinnerBuilder()
                .withStyle(.large)
                .isAnimating(true)
                .build()
        }
    }
}

public class ChartTopArtistsResultsViewBuilder: BuilderProtocol {
    
    private var viewModel: ChartTopArtistsViewModel?
    
    public func withViewModel(_ viewModel: ChartTopArtistsViewModel) -> ChartTopArtistsResultsViewBuilder {
        self.viewModel = viewModel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let viewModel = viewModel {
            ChartTopArtistsResultsView(viewModel: viewModel)
        } else {
            EmptyView()
        }
    }
}

struct ChartTopArtistsResultsView_Previews: PreviewProvider {

    enum TestError: Error {
        case dummy
    }
    
    static var previews: some View {
        Group {
            ChartTopArtistsResultsViewBuilder()
                .withViewModel(ChartTopArtistsViewModel())
                .build()
                .previewDisplayName("default state = .idle")
            ChartTopArtistsResultsViewBuilder()
                .withViewModel(ChartTopArtistsViewModel(state: .loading))
                .build()
                .previewDisplayName("state = .loading")
            ChartTopArtistsResultsViewBuilder()
                .withViewModel(ChartTopArtistsViewModel(state: .error(TestError.dummy)))
                .build()
                .previewDisplayName("state = .error")
            ChartTopArtistsResultsViewBuilder()
                .withViewModel(ChartTopArtistsViewModel(state: .loaded([
                    ChartTopArtistRowItem(name: "Best artist",
                                         listeners: "12345678",
                                         playcount: "908223"),
                    ChartTopArtistRowItem(name: "Super good artist with a very long name that should appearon several lines of text",
                                         listeners: "12345678",
                                         playcount: "908223"),
                    ChartTopArtistRowItem(name: "Super good artist with a very long name that should appearon several lines of text",
                                         listeners: "12345678",
                                         playcount: "908223"),
                ])))
                .build()
                .previewDisplayName("state = .loaded")
            ChartTopArtistsResultsViewBuilder()
                .build()
                .previewDisplayName("No view model, so should not appear")
        }
    }
}

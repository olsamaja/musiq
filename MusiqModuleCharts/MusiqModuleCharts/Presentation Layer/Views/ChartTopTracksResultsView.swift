//
//  SearchTopTracksResultsView.swift
//  MusiqModuleTopTracks
//
//  Created by Olivier Rigault on 18/04/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct ChartTopTracksResultsView: View {
    
    @ObservedObject var viewModel: ChartTopTracksViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            MessageViewBuilder()
                .withMessage("Loading top tracks")
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
        case .loaded(let tracks):
            ChartTopTracksListViewBuilder()
                .withItems(tracks)
                .build()
        case .loading:
            SpinnerBuilder()
                .withStyle(.large)
                .isAnimating(true)
                .build()
        }
    }
}

public class ChartTopTracksResultsViewBuilder: BuilderProtocol {
    
    private var viewModel: ChartTopTracksViewModel?
    
    public func withViewModel(_ viewModel: ChartTopTracksViewModel) -> ChartTopTracksResultsViewBuilder {
        self.viewModel = viewModel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let viewModel = viewModel {
            ChartTopTracksResultsView(viewModel: viewModel)
        } else {
            EmptyView()
        }
    }
}

struct ChartTopTracksResultsView_Previews: PreviewProvider {

    enum TestError: Error {
        case dummy
    }
    
    static var previews: some View {
        Group {
            ChartTopTracksResultsViewBuilder()
                .withViewModel(ChartTopTracksViewModel())
                .build()
                .previewDisplayName("default state = .idle")
            ChartTopTracksResultsViewBuilder()
                .withViewModel(ChartTopTracksViewModel(state: .loading))
                .build()
                .previewDisplayName("state = .loading")
            ChartTopTracksResultsViewBuilder()
                .withViewModel(ChartTopTracksViewModel(state: .error(TestError.dummy)))
                .build()
                .previewDisplayName("state = .error")
            ChartTopTracksResultsViewBuilder()
                .withViewModel(ChartTopTracksViewModel(state: .loaded([
                    ChartTopTrackRowItem(name: "Best track", artistName: "Best artist"),
                    ChartTopTrackRowItem(name: "Super good track with a very long name that should appearon several lines of text", artistName: "Best artist"),
                    ChartTopTrackRowItem(name: "Super good track with a very long name that should appearon several lines of text", artistName: "Super popular artist with a very long name that should appearon several lines of text")
                ])))
                .build()
                .previewDisplayName("state = .loaded")
            ChartTopTracksResultsViewBuilder()
                .build()
                .previewDisplayName("No view model, so should not appear")
        }
    }
}

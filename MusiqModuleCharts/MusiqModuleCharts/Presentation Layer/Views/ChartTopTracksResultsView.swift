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

struct ChartTopTracksResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartTopTracksResultsView(viewModel: ChartTopTracksViewModel())
    }
}

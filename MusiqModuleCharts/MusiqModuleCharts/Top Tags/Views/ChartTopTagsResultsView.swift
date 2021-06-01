//
//  ChartTopTagsResultsView.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 28/05/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct ChartTopTagsResultsView: View {
    
    @ObservedObject var viewModel: ChartTopTagsViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            MessageViewBuilder()
                .withMessage("Loading top tags")
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
        case .loaded(let tags):
            ChartTopTagsListViewBuilder()
                .withItems(tags)
                .build()
        case .loading:
            SpinnerBuilder()
                .withStyle(.large)
                .isAnimating(true)
                .build()
        }
    }
}

public class ChartTopTagsResultsViewBuilder: BuilderProtocol {
    
    private var viewModel: ChartTopTagsViewModel?
    
    public func withViewModel(_ viewModel: ChartTopTagsViewModel) -> ChartTopTagsResultsViewBuilder {
        self.viewModel = viewModel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let viewModel = viewModel {
            ChartTopTagsResultsView(viewModel: viewModel)
        } else {
            EmptyView()
        }
    }
}

//struct ChartTopTagsResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartTopTagsResultsView()
//    }
//}

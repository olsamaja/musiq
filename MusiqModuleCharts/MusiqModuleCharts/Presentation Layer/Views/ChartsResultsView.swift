//
//  ChartsResultsView.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 21/04/2021.
//

import SwiftUI
import Resolver

public struct ChartsResultsView: View {
    
    @Binding var chartType: ChartType
    @Injected var viewModel: ChartTopTracksViewModel

    public var body: some View {
        switch chartType {
        case .topTracks:
            ChartTopTracksResultsViewBuilder()
                .withViewModel(viewModel)
                .build()
                .navigationTitle("Charts")
        case .topArtists:
            ChartTopArtistsResultsView()
                .navigationTitle("Charts")
        }
    }
}

struct ChartsResultsView_Previews: PreviewProvider {
    
    @State static var selectedChartType: ChartType = .topTracks

    enum TestError: Error {
        case dummy
    }
    
    enum Dependencies {
        static var registerLoadingState = { () -> Bool in
            Resolver.register { ChartTopTracksViewModel(state: .loading) as ChartTopTracksViewModel }
            return true
        }
    }
    
    static var previews: some View {
        Group {
            if Dependencies.registerLoadingState() {
                ChartsResultsView(chartType: $selectedChartType)
                    .previewDisplayName("state = .loading")
            }
        }
    }
}

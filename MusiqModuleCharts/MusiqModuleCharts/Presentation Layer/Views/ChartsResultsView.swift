//
//  ChartsResultsView.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 21/04/2021.
//

import SwiftUI

public struct ChartsResultsView: View {
    
    @Binding var chartType: ChartType
    
    public var body: some View {
        switch chartType {
        case .topTracks:
            ChartTopTracksResultsViewBuilder()
                .withViewModel(ChartTopTracksViewModel())
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

    static var previews: some View {
        ChartsResultsView(chartType: $selectedChartType)
    }
}

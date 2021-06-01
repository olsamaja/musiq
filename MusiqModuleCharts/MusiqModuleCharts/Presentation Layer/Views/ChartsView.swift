//
//  ChartsView.swift
//  MusiqModuleTopTracks
//
//  Created by Olivier Rigault on 18/04/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

enum ChartType: String, CaseIterable {
    case topTracks = "Top Tracks"
    case topArtists = "Top Artists"
    case topTags = "Top Tags"
}

public struct ChartsView: View {
    
    @State private var selectedChartType: ChartType = .topTracks

    public init() {}
    
    public var body: some View {
        NavigationView {
            ChartsResultsView(chartType: $selectedChartType)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Picker("Chart", selection: $selectedChartType) {
                            ForEach(ChartType.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
        }
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}

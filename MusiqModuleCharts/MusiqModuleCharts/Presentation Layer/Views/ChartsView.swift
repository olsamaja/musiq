//
//  ChartsView.swift
//  MusiqModuleTopTracks
//
//  Created by Olivier Rigault on 18/04/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

public struct ChartsView: View {
    
    @State private var chart: Int = 0

    public init() {}
    
    public var body: some View {
        NavigationView {
            ChartsContainerView()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Picker("Chart", selection: $chart) {
                            Text("Top Tracks").tag(0)
                            Text("Top Albums").tag(1)
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

public struct ChartsContainerView: View {
    
    public init() {}
    
    public var body: some View {
        ChartTopTracksResultsViewBuilder()
            .withViewModel(ChartTopTracksViewModel())
            .build()
            .navigationTitle("Charts")
    }
}


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
    
    public init() {}
    
    public var body: some View {
        NavigationView {
                ChartTopTracksResultsViewBuilder()
                    .withViewModel(ChartTopTracksViewModel())
                    .build()
                    .navigationTitle("Charts")
        }
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}

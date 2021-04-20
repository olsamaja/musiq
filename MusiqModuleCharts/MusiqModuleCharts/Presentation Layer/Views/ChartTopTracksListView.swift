//
//  ChartTopTracksListView.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 20/04/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct ChartTopTracksListView: View {
    
    var items: [ChartTopTrackRowItem]
    
    var body: some View {
        return List(items) { item in
            NavigationLink(
                destination: MessageViewBuilder()
                    .withMessage("Test")
                    .build(),
                label: {
                    ChartTopTrackRowViewBuilder()
                        .withItem(item)
                        .build()
                }
            )
        }
    }
}

public class ChartTopTracksListViewBuilder: BuilderProtocol {
    
    var items: [ChartTopTrackRowItem]?

    public func withItems(_ items: [ChartTopTrackRowItem]) -> ChartTopTracksListViewBuilder {
        self.items = items
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let items = items {
            ChartTopTracksListView(items: items)
        } else {
            EmptyView()
        }
    }
}

struct ChartTopTracksListView_Previews: PreviewProvider {
    static var previews: some View {
        ChartTopTracksListViewBuilder()
            .withItems([
                ChartTopTrackRowItem(name: "Always Remember Us This Way", artistName: "Elvis Presley"),
                ChartTopTrackRowItem(name: "What a wondeful world!", artistName: "Louis Armstrong"),
                ChartTopTrackRowItem(name: "Mr. Tambourine Man", artistName: "Bob Dylan")
            ])
            .build()
    }
}

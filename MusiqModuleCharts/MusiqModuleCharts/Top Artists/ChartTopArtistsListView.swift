//
//  ChartTopArtistsListView.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 27/05/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct ChartTopArtistsListView: View {
    
    var items: [ChartTopArtistRowItem]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(items) { item in
                    ChartTopArtistRowViewBuilder()
                        .withItem(item)
                        .build()
                }
            }
        }
    }
}

public class ChartTopArtistsListViewBuilder: BuilderProtocol {
    
    var items: [ChartTopArtistRowItem]?

    public func withItems(_ items: [ChartTopArtistRowItem]) -> ChartTopArtistsListViewBuilder {
        self.items = items
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let items = items {
            ChartTopArtistsListView(items: items)
        } else {
            EmptyView()
        }
    }
}

struct ChartTopArtistsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChartTopArtistsListViewBuilder()
            .withItems([
                ChartTopArtistRowItem(name: "Elvis Presley",
                                      listeners: "12345678",
                                      playcount: "908223"),
                ChartTopArtistRowItem(name: "Louis Armstrong",
                                      listeners: "12345678",
                                      playcount: "908223"),
                ChartTopArtistRowItem(name: "Bob Dylan",
                                      listeners: "12345678",
                                      playcount: "908223")
            ])
            .build()
    }
}

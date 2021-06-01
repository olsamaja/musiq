//
//  ChartTopTagsListView.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 01/06/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct ChartTopTagsListView: View {
    
    var items: [ChartTopTagRowItem]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(items) { item in
                    ChartTopTagRowViewBuilder()
                        .withItem(item)
                        .build()
                }
            }
        }
    }
}

public class ChartTopTagsListViewBuilder: BuilderProtocol {
    
    var items: [ChartTopTagRowItem]?

    public func withItems(_ items: [ChartTopTagRowItem]) -> ChartTopTagsListViewBuilder {
        self.items = items
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let items = items {
            ChartTopTagsListView(items: items)
        } else {
            EmptyView()
        }
    }
}

struct ChartTopTagsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChartTopTagsListViewBuilder()
            .withItems([
                ChartTopTagRowItem(name: "Rock",
                                   taggings: "12345678"),
                ChartTopTagRowItem(name: "Jazz",
                                   taggings: "12345678"),
                ChartTopTagRowItem(name: "Reggae",
                                   taggings: "12345678"),
            ])
            .build()
    }
}

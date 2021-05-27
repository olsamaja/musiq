//
//  ChartTopArtistRowView.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 27/05/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct ChartTopArtistRowView: View {
    
    var item: ChartTopArtistRowItem
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text(item.name)
                    .font(.headline)
                Spacer()
                BadgeViewBuilder()
                    .withText(item.playcount)
                    .withBackgroundColor(.gray)
                    .build()
            }
            Spacer(minLength: 4)
            HStack() {
                Spacer()
                BadgeViewBuilder()
                    .withText(item.listeners)
                    .build()
            }
            Divider()
        }
        .padding([.top, .leading, .trailing])
    }
}

public class ChartTopArtistRowViewBuilder: BuilderProtocol {
    
    private var item: ChartTopArtistRowItem?

    public func withItem(_ item: ChartTopArtistRowItem) -> ChartTopArtistRowViewBuilder {
        self.item = item
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let item = item {
            ChartTopArtistRowView(item: item)
        } else {
            EmptyView()
        }
    }
}


struct ChartTopArtistRowView_Previews: PreviewProvider {
    static var previews: some View {
        ChartTopArtistRowView(item: ChartTopArtistRowItem(name: "Artist",
                                                          listeners: "1234",
                                                          playcount: "123456"))
            .sizeThatFitPreview(with: "Default")
    }
}

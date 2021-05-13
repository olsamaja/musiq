//
//  ChartTopTrackRowView.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 20/04/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct ChartTopTrackRowView: View {

    var item: ChartTopTrackRowItem
    
    var body: some View {
        VStack {
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
                Text(item.artistName)
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

public class ChartTopTrackRowViewBuilder: BuilderProtocol {
    
    private var item: ChartTopTrackRowItem?

    public func withItem(_ item: ChartTopTrackRowItem) -> ChartTopTrackRowViewBuilder {
        self.item = item
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let item = item {
            ChartTopTrackRowView(item: item)
        } else {
            EmptyView()
        }
    }
}

struct ChartTopTrackRowView_Previews: PreviewProvider {
    static var previews: some View {
        ChartTopTrackRowView(item: ChartTopTrackRowItem(name: "Track",
                                                        artistName: "Artist",
                                                        listeners: "1234",
                                                        playcount: "123456"))
            .sizeThatFitPreview(with: "Default")
    }
}

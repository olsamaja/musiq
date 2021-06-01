//
//  ChartTopTagRowView.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 01/06/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct ChartTopTagRowView: View {
    
    var item: ChartTopTagRowItem
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text(item.name)
                    .font(.headline)
                Spacer()
                BadgeViewBuilder()
                    .withText(item.taggings)
                    .withBackgroundColor(.gray)
                    .build()
            }
            Spacer(minLength: 4)
            Divider()
        }
        .padding([.top, .leading, .trailing])
    }
}

public class ChartTopTagRowViewBuilder: BuilderProtocol {
    
    private var item: ChartTopTagRowItem?

    public func withItem(_ item: ChartTopTagRowItem) -> ChartTopTagRowViewBuilder {
        self.item = item
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let item = item {
            ChartTopTagRowView(item: item)
        } else {
            EmptyView()
        }
    }
}


struct ChartTopTagRowView_Previews: PreviewProvider {
    static var previews: some View {
        ChartTopTagRowView(item: ChartTopTagRowItem(name: "Tag", taggings: "Rock"))
            .sizeThatFitPreview(with: "Default")
    }
}

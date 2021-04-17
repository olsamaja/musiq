//
//  ArtistsListView.swift
//  MusiqModuleArtists
//
//  Created by Olivier Rigault on 07/04/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct ArtistsListView: View {

    var items: [ArtistRowItem]
    
    var body: some View {
        return List(items) { item in
            NavigationLink(
                destination: MessageViewBuilder()
                    .withMessage("Test")
                    .build(),
                label: {
                    ArtistRowViewBuilder()
                        .withItem(item)
                        .build()
                        .onAppear() {
                            if items.last == item {
                                OLLogger.info("Last Row: \(item.name)")
                            }
                        }
                }
            )
        }
    }
}

public class ArtistsListViewBuilder: BuilderProtocol {
    
    var items: [ArtistRowItem]?

    public func withItems(_ items: [ArtistRowItem]) -> ArtistsListViewBuilder {
        self.items = items
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let items = items {
            ArtistsListView(items: items)
        } else {
            EmptyView()
        }
    }
}

struct ArtistsListView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsListViewBuilder()
            .withItems([
                ArtistRowItem(name: "Elvis"),
                ArtistRowItem(name: "Bob Dylan", listeners: "123456"),
                ArtistRowItem(name: "Bob Marley", listeners: "A huge number"),
                ArtistRowItem(name: "A super very long name for an artist group", listeners: "123456"),
                ArtistRowItem(name: "Lisa Marie Preley"),
                ArtistRowItem(name: "Frank Sinatra", listeners: "123456"),
                ArtistRowItem(name: "Elvis"),
                ArtistRowItem(name: "Bob Dylan", listeners: "123456"),
                ArtistRowItem(name: "Bob Marley", listeners: "A huge number"),
                ArtistRowItem(name: "A super very long name for an artist group", listeners: "123456"),
                ArtistRowItem(name: "Elvis"),
                ArtistRowItem(name: "Bob Dylan", listeners: "123456"),
                ArtistRowItem(name: "Bob Marley", listeners: "A huge number"),
                ArtistRowItem(name: "A super very long name for an artist group", listeners: "123456")
            ])
            .build()
            .previewDisplayName("Long list")
        ArtistsListViewBuilder()
            .withItems([
                ArtistRowItem(name: "Elvis", listeners: "123"),
                ArtistRowItem(name: "A super very long name for an artist group"),
                ArtistRowItem(name: "Bob Dylan", listeners: "A super very long number of fans for an artist")
            ])
            .build()
            .previewDisplayName("Small list")
    }
}

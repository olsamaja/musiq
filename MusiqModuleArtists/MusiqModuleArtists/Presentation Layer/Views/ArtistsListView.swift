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

    var items: [ArtistCardItem]
    
    var body: some View {
        return List(items) { item in
            NavigationLink(
                destination: ErrorViewBuilder()
                    .withMessage("Test")
                    .build(),
                label: {
                    ArtistCardViewBuilder()
                        .withItem(item)
                        .build()
                }
            )
        }
    }
}

public class ArtistsListViewBuilder: BuilderProtocol {
    
    var items: [ArtistCardItem]?

    public func withItems(_ items: [ArtistCardItem]) -> ArtistsListViewBuilder {
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
                ArtistCardItem(name: "Elvis"),
                ArtistCardItem(name: "Bob Dylan", listeners: "123456"),
                ArtistCardItem(name: "Bob Marley", listeners: "A huge number"),
                ArtistCardItem(name: "A super very long name for an artist group", listeners: "123456"),
                ArtistCardItem(name: "Lisa Marie Preley"),
                ArtistCardItem(name: "Frank Sinatra", listeners: "123456"),
                ArtistCardItem(name: "Elvis"),
                ArtistCardItem(name: "Bob Dylan", listeners: "123456"),
                ArtistCardItem(name: "Bob Marley", listeners: "A huge number"),
                ArtistCardItem(name: "A super very long name for an artist group", listeners: "123456"),
                ArtistCardItem(name: "Elvis"),
                ArtistCardItem(name: "Bob Dylan", listeners: "123456"),
                ArtistCardItem(name: "Bob Marley", listeners: "A huge number"),
                ArtistCardItem(name: "A super very long name for an artist group", listeners: "123456")
            ])
            .build()
    }
}

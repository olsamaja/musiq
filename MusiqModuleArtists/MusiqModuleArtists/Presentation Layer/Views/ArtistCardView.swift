//
//  ArtistCardView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 20/03/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct ArtistCardView: View {
    
    var item: ArtistCardItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(item.name)
                    .font(.title2)
                Spacer(minLength: 10)
                item.listeners.map { listeners in
                    BadgeViewBuilder()
                        .withText(listeners)
                        .build()
                        .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
}

public class ArtistCardViewBuilder: BuilderProtocol {
    
    private var item: ArtistCardItem?

    public func withItem(_ item: ArtistCardItem) -> ArtistCardViewBuilder {
        self.item = item
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let item = item {
            ArtistCardView(item: item)
        } else {
            EmptyView()
        }
    }
}

struct ArtistCardView_Previews: PreviewProvider {
    
    enum Constants {
        static let item1 = ArtistCardItem(name: "This is a name")
        static let item2 = ArtistCardItem(name: "This is a very long name for an artist")
        static let item3 = ArtistCardItem(name: "This is a very long name for an artist", listeners: "listeners")
    }
    
    static var previews: some View {
        Group {
            ArtistCardViewBuilder()
                .withItem(Constants.item1)
                .build()
                .sizeThatFitPreview(with: "Short artist name")

            ArtistCardViewBuilder()
                .withItem(Constants.item2)
                .build()
                .sizeThatFitPreview(with: "Long artist name")

            ArtistCardViewBuilder()
                .withItem(Constants.item3)
                .build()
                .sizeThatFitPreview(with: "Default")

            ArtistCardViewBuilder()
                .withItem(Constants.item3)
                .build()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .sizeThatFitPreview(with: "Long artist name")
        }
    }
}

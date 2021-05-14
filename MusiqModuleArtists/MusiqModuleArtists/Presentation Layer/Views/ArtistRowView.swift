//
//  ArtistRowView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 20/03/2021.
//

import SwiftUI
import MusiqCoreUI
import MusiqCore

struct ArtistRowView: View {
    
    var item: ArtistRowItem
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text(item.name)
                    .font(.body)
                Spacer(minLength: 10)
                item.listeners.map { listeners in
                    BadgeViewBuilder()
                        .withText(listeners)
                        .build()
                        .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .trailing)
                }
            }
            Divider()
        }
        .padding([.leading, .trailing])
    }
}

public class ArtistRowViewBuilder: BuilderProtocol {
    
    private var item: ArtistRowItem?

    public func withItem(_ item: ArtistRowItem) -> ArtistRowViewBuilder {
        self.item = item
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let item = item {
            ArtistRowView(item: item)
        } else {
            EmptyView()
        }
    }
}

struct ArtistRowViewBuilder_Previews: PreviewProvider {
    
    enum Constants {
        static let item1 = ArtistRowItem(name: "This is a name")
        static let item2 = ArtistRowItem(name: "This is a very long name for an artist")
        static let item3 = ArtistRowItem(name: "This is a very long name for an artist", listeners: "listeners")
    }
    
    static var previews: some View {
        Group {
            ArtistRowViewBuilder()
                .withItem(Constants.item1)
                .build()
                .sizeThatFitPreview(with: "Short artist name")

            ArtistRowViewBuilder()
                .withItem(Constants.item2)
                .build()
                .sizeThatFitPreview(with: "Long artist name")

            ArtistRowViewBuilder()
                .withItem(Constants.item3)
                .build()
                .sizeThatFitPreview(with: "Default")

            ArtistRowViewBuilder()
                .withItem(Constants.item3)
                .build()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .sizeThatFitPreview(with: "Long artist name")
        }
    }
}

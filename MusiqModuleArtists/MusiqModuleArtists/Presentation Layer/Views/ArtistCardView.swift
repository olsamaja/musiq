//
//  ArtistCardView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 20/03/2021.
//

import SwiftUI
import MusiqCoreUI

struct ArtistCardView: View {
    var item: ArtistCardItem
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(item.name)
                    .font(.title2)
                Spacer(minLength: 10)
                    .background(Color.yellow)
                item.listeners.map { listeners in
                    BadgeViewBuilder()
                        .withText(listeners)
                        .build()
                        .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .trailing)
                }
            }
            Divider()
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
            ArtistCardView(item: Constants.item1)
                .sizeThatFitPreview(with: "Short artist name")

            ArtistCardView(item: Constants.item2)
                .sizeThatFitPreview(with: "Long artist name")

            ArtistCardView(item: Constants.item3)
                .sizeThatFitPreview(with: "Default")

            ArtistCardView(item: Constants.item3)
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .sizeThatFitPreview(with: "Long artist name")
        }
    }
}

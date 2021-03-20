//
//  ArtistCardView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 20/03/2021.
//

import SwiftUI

struct ArtistCardView: View {
    var item: ArtistItem
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(item.name)
                    .font(.title2)
                Spacer(minLength: 10)
                Text(String(item.listeners))
                    .font(.title3)
            }
            Divider()
        }
    }
}

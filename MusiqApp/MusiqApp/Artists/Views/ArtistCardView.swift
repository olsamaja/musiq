//
//  ArtistCardView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 20/03/2021.
//

import SwiftUI
import MusiqCoreUI

struct ArtistCardView: View {
    var item: ArtistItem
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(item.name)
                    .font(.title2)
                Spacer(minLength: 10)
                    .background(Color.yellow)
                item.listeners.map { listeners in
                    BadgeView(text: listeners, backgroundColor: .purple)
                        .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .trailing)
                }
            }
            Divider()
        }
    }
}

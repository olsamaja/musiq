//
//  SearchContentView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 21/03/2021.
//

import SwiftUI
import MusiqCoreUI

struct SearchContentView: View {
    
    @ObservedObject var viewModel: ArtistsViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            VStack {
                Text("Search artists, for example, Elvis")
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(.body)
                Spacer()
            }
        case .error(let error):
            ErrorViewBuilder()
                .withSymbol("xmark.octagon")
                .withMessage(error.localizedDescription)
                .build()
        case .loaded(let artists):
            VStack {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 15) {
                        ForEach(artists) { item in
                            ArtistCardView(item: item)
                        }
                    }
                    .padding()
                }
            }
        case .searching:
            Spinner(isAnimating: true, style: .large)
        }
    }
}

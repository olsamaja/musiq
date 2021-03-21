//
//  HomeView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 20/03/2021.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var filteredItems: [ArtistItem]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 15) {
                ForEach(filteredItems) { item in
                    ArtistCardView(item: item)
                }
            }
            .padding()
        }
    }
}

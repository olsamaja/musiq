//
//  ArtistsView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 21/12/2020.
//

import SwiftUI
import MusiqCoreUI

struct ArtistsView: View {
    
    @ObservedObject var viewModel: ArtistsViewModel
    
    var body: some View {
        NavigationView {
            Background {
                VStack(alignment: .leading) {
                    SearchBar(placeholder: "Search...", text: $viewModel.searchTerm)
                    subContent
                    Spacer()
                }
            }
            .padding()
            .navigationBarTitle("Search")
            .onTapGesture {
                self.hideKeyboard()
            }
        }
    }
    
    @ViewBuilder
    private var subContent: some View {
        switch viewModel.state {
        case .idle:
            Text("Search artists, for example, Elvis")
                .padding()
                .multilineTextAlignment(.center)
                .font(.body)
        case .error(let error):
            Text(error.localizedDescription)
                .padding()
                .multilineTextAlignment(.center)
                .font(.body)
        case .loaded(let artists):
            list(of: artists)
        case .searching:
            Spinner(isAnimating: true, style: .large)
        }
    }
    
    private func list(of items: [ArtistsViewModel.ListItem]) -> some View {
        return List(items) { item in
            Text(item.name)
//            NavigationLink(
//                destination: ArtistInfoView(viewModel: ArtistInfoViewModel(name: item.name)),
//                label: { ArtistListItemView(item: item) }
//            )
        }
    }
}

struct ArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsView(viewModel: ArtistsViewModel())
    }
}

struct ArtistListItemView: View {
    
    let item: ArtistsViewModel.ListItem
    
    private enum Constants {
        static let imageDimensions: CGFloat = 32
        static let imageCornerRadius: CGFloat = 4
    }
    
    var body: some View {
        HStack {
            Text(item.name)
                .font(.headline)
                .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
            item.listeners.map { listeners in
                BadgeView(text: listeners, backgroundColor: .purple)
                    .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

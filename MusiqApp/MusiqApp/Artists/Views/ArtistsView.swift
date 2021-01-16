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
                    Text("Hello, World!")
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
}

struct ArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsView(viewModel: ArtistsViewModel())
    }
}

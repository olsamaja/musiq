//
//  ContentView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 20/03/2021.
//

import SwiftUI
import MusiqCoreUI

struct ContentView: View {
    
    @State var filteredItems = artists
    
    var body: some View {
        SearchNavigationView(
            view: AnyView(HomeView(filteredItems: $filteredItems)),
            useLargeTitle: true,
            title: "Search",
            placeholder: "Search artists",
            onSearch: { (searchText) in
                if searchText.isEmpty {
                    self.filteredItems = artists
                } else {
                    self.filteredItems = artists.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                }
            },
            onCancel: {
                self.filteredItems = artists
             })
            . ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

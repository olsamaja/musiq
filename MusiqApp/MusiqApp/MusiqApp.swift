//
//  MusiqApp.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 21/12/2020.
//

import SwiftUI
import MusiqConfiguration
import MusiqShared
import MusiqCore

@main
struct MusiqApp: App {
    
    var body: some Scene {
        WindowGroup {
//            ArtistsView(viewModel: ArtistsViewModel())
            SearchContentView(viewModel: ArtistsViewModel())
        }
    }
}

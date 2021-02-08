//
//  MusiqAppApp.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 21/12/2020.
//

import SwiftUI
import MusiqConfiguration
import MusiqShared
import MusiqCore

@main
struct MusiqAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            ArtistsView(viewModel: ArtistsViewModel())
        }
    }
}

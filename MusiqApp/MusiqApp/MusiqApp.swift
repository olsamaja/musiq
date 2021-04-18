//
//  MusiqApp.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 21/12/2020.
//

import SwiftUI
import MusiqModuleArtists
import MusiqModuleTopTags
import MusiqModuleTopTracks

@main
struct MusiqApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabView {
                SearchArtistsView()
                    .tabItem {
                        Image(systemName: "music.note.list")
                        Text("Artists")
                    }
                ChartsView()
                    .tabItem {
                        Image(systemName: "music.note")
                        Text("Charts")
                    }
                SearchTopTagsView()
                    .tabItem {
                        Image(systemName: "tag")
                        Text("Top Tags")
                    }
            }
        }
    }
}

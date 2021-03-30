//
//  ArtistCardItem.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 20/03/2021.
//

import Foundation
import MusiqShared
import MusiqModuleArtists

public struct ArtistCardItem: Identifiable {
    
    public var id: String
    var name: String
    var listeners: String?
    
    init(artist: Artist) {
        self.id = UUID().uuidString
        self.name = artist.name
        self.listeners = artist.listeners
    }
}

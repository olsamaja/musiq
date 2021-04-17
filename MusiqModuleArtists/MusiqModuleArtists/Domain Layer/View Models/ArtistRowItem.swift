//
//  ArtistRowItem.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 20/03/2021.
//

import Foundation
import MusiqNetwork

public struct ArtistRowItem: Identifiable {
    
    public let id: String
    let name: String
    let listeners: String?
    
    init(artist: Artist) {
        self.id = UUID().uuidString
        self.name = artist.name
        self.listeners = artist.listeners
    }
    
    init(name: String, listeners: String? = nil) {
        self.id = UUID().uuidString
        self.name = name
        self.listeners = listeners
    }
}

extension ArtistRowItem: Equatable {}

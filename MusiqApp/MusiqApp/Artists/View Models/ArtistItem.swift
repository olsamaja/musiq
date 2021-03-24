//
//  ArtistItem.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 20/03/2021.
//

import Foundation
import MusiqShared

public struct ArtistItem: Identifiable {
    
    public var id: String
    var name: String
    var listeners: String?
    
    init(artist: Artist) {
        self.id = UUID().uuidString
        self.name = artist.name
        self.listeners = artist.listeners
    }
}

var artists: [ArtistItem] = [
//    ArtistItem(name: "Bod Marley", listeners: 1897),
//    ArtistItem(name: "Vear Lynn", listeners: 298),
//    ArtistItem(name: "Elvis Presley", listeners: 20982),
//    ArtistItem(name: "Franck Sinitra", listeners: 872),
//    ArtistItem(name: "Bob Dylan", listeners: 112),
//    ArtistItem(name: "Penelope Cruz", listeners: 0),
//    ArtistItem(name: "Madonna", listeners: 2870287),
//    ArtistItem(name: "David Bowie", listeners: 2872),
//    ArtistItem(name: "Charles Trenet", listeners: 198),
//    ArtistItem(name: "Aretha Franklin", listeners: 99),
//    ArtistItem(name: "Louis Armstong", listeners: 765)
]

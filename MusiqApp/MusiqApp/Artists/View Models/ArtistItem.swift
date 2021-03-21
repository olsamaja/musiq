//
//  ArtistItem.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 20/03/2021.
//

import Foundation

struct ArtistItem: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var listeners: Int
}

var artists = [
    ArtistItem(name: "Bod Marley", listeners: 1897),
    ArtistItem(name: "Vear Lynn", listeners: 298),
    ArtistItem(name: "Elvis Presley", listeners: 20982),
    ArtistItem(name: "Franck Sinitra", listeners: 872),
    ArtistItem(name: "Bob Dylan", listeners: 112),
    ArtistItem(name: "Penelope Cruz", listeners: 0),
    ArtistItem(name: "Madonna", listeners: 2870287),
    ArtistItem(name: "David Bowie", listeners: 2872),
    ArtistItem(name: "Charles Trenet", listeners: 198),
    ArtistItem(name: "Aretha Franklin", listeners: 99),
    ArtistItem(name: "Louis Armstong", listeners: 765)
]

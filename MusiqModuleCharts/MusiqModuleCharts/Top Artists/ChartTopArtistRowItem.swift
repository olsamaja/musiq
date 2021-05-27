//
//  ChartTopArtistRowItem.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 27/05/2021.
//

import Foundation

public struct ChartTopArtistRowItem: Identifiable {
    
    public let id: String
    let name: String
    let listeners: String
    let playcount: String

    init(artist: ChartTopArtist) {
        self.id = UUID().uuidString
        self.name = artist.name
        self.listeners = artist.listeners
        self.playcount = artist.playcount
    }
    
    init(name: String, listeners: String, playcount: String) {
        self.id = UUID().uuidString
        self.name = name
        self.listeners = listeners
        self.playcount = playcount
    }
}

extension ChartTopArtistRowItem: Equatable {}

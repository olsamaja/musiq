//
//  ChartTopTrackRowItem.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 19/04/2021.
//

import Foundation

public struct ChartTopTrackRowItem: Identifiable {
    
    public let id: String
    let name: String
    let artistName: String
    let listeners: String
    let playcount: String

    init(track: ChartTopTrack) {
        self.id = UUID().uuidString
        self.name = track.name
        self.artistName = track.artistName
        self.listeners = track.listeners
        self.playcount = track.playcount
    }
    
    init(name: String, artistName: String, listeners: String, playcount: String) {
        self.id = UUID().uuidString
        self.name = name
        self.artistName = artistName
        self.listeners = listeners
        self.playcount = playcount
    }
}

extension ChartTopTrackRowItem: Equatable {}

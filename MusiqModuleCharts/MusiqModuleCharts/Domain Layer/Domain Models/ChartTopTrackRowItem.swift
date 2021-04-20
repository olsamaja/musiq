//
//  ChartTopTrackRowItem.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 19/04/2021.
//

import Foundation
import MusiqNetwork

public struct ChartTopTrackRowItem: Identifiable {
    
    public let id: String
    let name: String
    let artistName: String

    init(track: ChartTopTrack) {
        self.id = UUID().uuidString
        self.name = track.name
        self.artistName = track.artistName
    }
    
    init(name: String, artistName: String) {
        self.id = UUID().uuidString
        self.name = name
        self.artistName = artistName
    }
}

extension ChartTopTrackRowItem: Equatable {}

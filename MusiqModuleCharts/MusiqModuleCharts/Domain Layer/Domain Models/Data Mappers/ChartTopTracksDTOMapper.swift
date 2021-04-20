//
//  ChartTopTracksDTOMapper.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 19/04/2021.
//

import Foundation

public struct ChartTopTracksDTOMapper {
    
    static func map(_ dto: ChartTopTracksDTO) -> [ChartTopTrack] {
        dto.tracks.track.map {
            ChartTopTrack(name: $0.name,
                          artistName: $0.artist.name,
                          listeners: $0.listeners,
                          playcount: $0.playcount)
        }
    }
}

//
//  ChartTrackDTOMapper.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 19/04/2021.
//

import Foundation

public struct ChartTopTrackDTOMapper {
    
    static func map(_ dto: ChartTopTrackDTO) -> ChartTopTrack {
        ChartTopTrack(name: dto.name,
                      artistName: dto.artist.name,
                      listeners: dto.listeners,
                      playcount: dto.playcount)
    }
}

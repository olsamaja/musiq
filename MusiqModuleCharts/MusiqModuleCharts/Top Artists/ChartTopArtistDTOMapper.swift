//
//  ChartTopArtistDTOMapper.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 27/05/2021.
//

import Foundation

public struct ChartTopArtistDTOMapper {
    
    static func map(_ dto: ChartTopArtistDTO) -> ChartTopArtist {
        ChartTopArtist(name: dto.name,
                      listeners: dto.listeners,
                      playcount: dto.playcount)
    }
}

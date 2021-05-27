//
//  ChartTopArtistsDTOMapper.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 27/05/2021.
//

import Foundation

public struct ChartTopArtistsDTOMapper {
    
    static func map(_ dto: ChartTopArtistsDTO) -> [ChartTopArtist] {
        dto.artists.artist.map {
            ChartTopArtist(name: $0.name,
                          listeners: $0.listeners,
                          playcount: $0.playcount)
        }
    }
}

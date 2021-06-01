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
            ChartTopArtistDTOMapper.map($0)
        }
    }
}

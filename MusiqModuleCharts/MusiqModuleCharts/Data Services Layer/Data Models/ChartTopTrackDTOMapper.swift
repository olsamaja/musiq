//
//  ChartTrackDTOMapper.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 19/04/2021.
//

import Foundation

public struct ChartTopTrackDTOMapper {
    
    static func map(_ dto: ChartTopTrackDTO) -> ChartTopTrack {
        return ChartTopTrack(name: dto.name)
    }
}

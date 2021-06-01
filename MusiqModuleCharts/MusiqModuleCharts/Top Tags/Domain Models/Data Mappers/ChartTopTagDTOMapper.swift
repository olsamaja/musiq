//
//  ChartTopTagDTOMapper.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 28/05/2021.
//

import Foundation

public struct ChartTopTagDTOMapper {
    
    static func map(_ dto: ChartTopTagDTO) -> ChartTopTag {
        ChartTopTag(name: dto.name, taggings: dto.taggings)
    }
}

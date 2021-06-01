//
//  ChartTopTagsDTOMapper.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 28/05/2021.
//

import Foundation

public struct ChartTopTagsDTOMapper {
    
    static func map(_ dto: ChartTopTagsDTO) -> [ChartTopTag] {
        dto.tags.tag.map {
            ChartTopTagDTOMapper.map($0)
        }
    }
}

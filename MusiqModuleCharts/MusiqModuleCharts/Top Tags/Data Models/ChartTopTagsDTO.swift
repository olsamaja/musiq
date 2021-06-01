//
//  ChartTopTagsDTO.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 28/05/2021.
//

import Foundation

// MARK: - Used in method=search.gettoptags

struct ChartTopTagDTO: Decodable {
    let name: String
    let taggings: String
}

struct ChartTopTagsResultsDTO: Decodable {
    let tag: [ChartTopTagDTO]
}

struct ChartTopTagsDTO: Decodable {
    let tags: ChartTopTagsResultsDTO
}

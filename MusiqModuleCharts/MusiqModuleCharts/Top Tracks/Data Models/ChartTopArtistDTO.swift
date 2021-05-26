//
//  ChartTopArtistDTO.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 26/05/2021.
//

import Foundation

// MARK: - Used in method=search.gettopartists

struct ChartTopArtistDTO: Decodable {
    let name: String
    let listeners: String
    let playcount: String
}

struct ChartTopArtistsResultsDTO: Decodable {
    let artist: [ChartTopArtistDTO]
}

struct ChartTopArtistsDTO: Decodable {
    let artists: ChartTopArtistsResultsDTO
}

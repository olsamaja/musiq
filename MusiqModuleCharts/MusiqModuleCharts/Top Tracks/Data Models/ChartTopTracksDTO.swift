//
//  ChartTopTracksDTO.swift
//  MusiqModuleTopTracks
//
//  Created by Olivier Rigault on 18/04/2021.
//

import Foundation

// MARK: - Used in method=search.gettoptracks

struct ChartTopTrackDTO: Decodable {
    let name: String
    let artist: ChartArtistDTO
    let listeners: String
    let playcount: String
}

struct ChartArtistDTO: Decodable {
    let name: String
}

struct ChartTopTracksResultsDTO: Decodable {
    let track: [ChartTopTrackDTO]
}

struct ChartTopTracksDTO: Decodable {
    let tracks: ChartTopTracksResultsDTO
}

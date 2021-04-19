//
//  SearchTopTtracksDTO.swift
//  MusiqModuleTopTracks
//
//  Created by Olivier Rigault on 18/04/2021.
//

import Foundation

// MARK: - Used in method=search.gettoptracks

struct TrackDTO: Decodable {
    let name: String
}

struct ChartTopTracksDTO: Decodable {
    let tracks: [TrackDTO]
}

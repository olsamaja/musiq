//
//  SearchArtistsDTO.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 26/12/2020.
//

import Foundation

// MARK: - Used in method=search.artist

struct ArtistMatchesDTO: Decodable {
    let artist: [ArtistDTO]
}

struct SearchArtistsResultsDTO {
    let artistMatches: ArtistMatchesDTO
}

extension SearchArtistsResultsDTO: Decodable {
    private enum CodingKeys : String, CodingKey {
        case artistMatches = "artistmatches"
    }
}

struct SearchArtistsDTO: Decodable {
    let results: SearchArtistsResultsDTO
}

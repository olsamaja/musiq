//
//  SearchArtistsDTOMapper.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 23/01/2021.
//

import Foundation

public struct SearchArtistsDTOMapper {
    
    static func map(_ dto: SearchArtistsDTO) -> [Artist] {
        
        let artistDTOs = dto.results.artistMatches.artist
        
        return artistDTOs.map {
            Artist(name: $0.name,
                   mbid: $0.mbid,
                   url: $0.url,
                   imageURL: $0.imageURL,
                   listeners: $0.listeners,
                   playcount: $0.playcount)
        }
    }
}

//
//  ArtistDTOMapper.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 23/01/2021.
//

import Foundation

public struct ArtistDTOMapper {
    
    static func map(_ dto: ArtistDTO) -> Artist {
        return Artist(name: dto.name,
                      mbid: dto.mbid,
                      url: dto.url,
                      imageURL: dto.imageURL,
                      listeners: dto.listeners,
                      playcount: dto.playcount)
    }
}

//
//  Artist.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 29/12/2020.
//

import Foundation

struct Artist {
    let name: String
    let mbid: String
    let url: URL?
    let imageURL: URL?
    let listeners: String?
    let playcount: String?
}

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

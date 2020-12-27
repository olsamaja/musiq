//
//  ArtistBioDTO.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 26/12/2020.
//

import Foundation

struct ArtistBioDTO: Decodable {
    let summary: String
    let content: String
    let published: String
}

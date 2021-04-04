//
//  Artist.swift
//  MusiqNetwork
//
//  Created by Olivier Rigault on 29/12/2020.
//

import Foundation

public struct Artist {
    public let name: String
    let mbid: String
    let url: URL?
    let imageURL: URL?
    public let listeners: String?
    let playcount: String?
    
    init(name: String, mbid: String, url: URL? = nil, imageURL: URL? = nil, listeners: String? = nil, playcount: String? = nil) {
        self.name = name
        self.mbid = mbid
        self.url = url
        self.imageURL = imageURL
        self.listeners = listeners
        self.playcount = playcount
    }
}

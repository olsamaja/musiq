//
//  ArtistDTO.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 26/12/2020.
//

import Foundation

struct ArtistDTO {
    let name: String
    let mbid: String
    let url: URL?
    let imageURL: URL?
    let listeners: String?
    let playcount: String?
    let bio: ArtistBioDTO?
}

extension ArtistDTO: Decodable {
    
    private enum CodingKeys : String, CodingKey {
        case name, mbid, url, image, stats, listeners, bio
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let mbid = try container.decode(String.self, forKey: .mbid)
        let urlString = try container.decode(String.self, forKey: .url)
        let url = URL(string: urlString)
        let imageURL = try container.decode([ImageDTO].self, forKey: .image).url(for: "large")
        
        var listenersStat: String? = nil
        var plapycountStat: String? = nil
        do {
            let stats = try container.decode(ArtistStatsDTO.self, forKey: .stats)
            listenersStat = stats.listeners
            plapycountStat = stats.playcount
        } catch {
            listenersStat = try container.decode(String.self, forKey: .listeners)
        }
        
        var bio: ArtistBioDTO? = nil
        if let artistBio = try? container.decode(ArtistBioDTO.self, forKey: .bio) {
            bio = ArtistBioDTO(summary: artistBio.summary, content: artistBio.content, published: artistBio.published)
        }

        self.init(name: name, mbid: mbid, url: url, imageURL: imageURL, listeners: listenersStat, playcount: plapycountStat, bio: bio)
    }
}

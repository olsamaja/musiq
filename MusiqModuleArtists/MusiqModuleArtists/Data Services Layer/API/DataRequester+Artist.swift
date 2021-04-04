//
//  DataRequester+Artist.swift
//  MusiqModuleArtists
//
//  Created by Olivier Rigault on 31/03/2021.
//

import Combine
import MusiqNetwork
import MusiqCore

extension DataRequester {
    
    func searchArtists(term: String) -> AnyPublisher<SearchArtistsDTO, DataError> {
        
        let urlComponents = URLComponentsBuilder()
            .with(key: "method", value: "artist.search")
            .with(key: "artist", value: term)
            .build()
        
        return loadData(with: urlComponents)
    }
}

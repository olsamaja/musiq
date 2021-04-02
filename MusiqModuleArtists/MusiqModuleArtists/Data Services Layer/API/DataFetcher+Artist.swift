//
//  DataFetcher+Artist.swift
//  MusiqModuleArtists
//
//  Created by Olivier Rigault on 31/03/2021.
//

import Combine
import MusiqShared

extension DataFetcher {
    
    func searchArtists(term: String) -> AnyPublisher<SearchArtistsDTO, DataError> {
        
        let urlComponents = URLComponentsBuilder()
            .with(key: "method", value: "artist.search")
            .with(key: "artist", value: term)
            .build()
        
        return loadData(with: urlComponents)
    }
}

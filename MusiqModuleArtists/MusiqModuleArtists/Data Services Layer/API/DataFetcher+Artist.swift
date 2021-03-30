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
        return loadData(with: makeSearchArtistsComponents(term: term))
    }

    private func makeSearchArtistsComponents(term: String) -> URLComponents {
        return makeComponents(with: ["method": "artist.search", "artist": term])
    }

}

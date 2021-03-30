//
//  ArtistDataManager.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 17/01/2021.
//

import Foundation
import Combine
import MusiqConfiguration
import MusiqCore
import MusiqShared

public class ArtistDataManager {
    
    var localRepository: ArtistLocalRepository
    var remoteRepository: ArtistRemoteRepository
    
    public init() {
        self.localRepository = ArtistLocalRepository()
        self.remoteRepository = ArtistRemoteRepository()
    }
    
    public func search(with term: String) -> AnyPublisher<[Artist], Error> {
        
        return remoteRepository.search(with: term)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

extension DataFetcher {
    
    func searchArtists(term: String) -> AnyPublisher<SearchArtistsDTO, DataError> {
        return loadData(with: makeSearchArtistsComponents(term: term))
    }

    private func makeSearchArtistsComponents(term: String) -> URLComponents {
        return makeComponents(with: ["method": "artist.search", "artist": term])
    }

}

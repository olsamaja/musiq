//
//  ArtistRepository.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 17/01/2021.
//

import Foundation
import Combine
import Resolver
import MusiqNetwork
import MusiqCore

struct ArtistLocalRepository: CachedDataProtocol {
    
    typealias T = Artist
    
    var cachedData: [Artist] = []

    func getAll() -> AnyPublisher<[Artist], DataError> {
        return Just(cachedData)
            .mapError { error in
                .parsing(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }

    func add(a: Artist) -> AnyPublisher<Bool, DataError> {
        return Just(true)
            .mapError { error in
                .parsing(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
}

struct ArtistRemoteRepository {
    
    typealias T = Artist
    
    func search(with term: String) -> AnyPublisher<[Artist], DataError> {
        
        return DataRequester.shared.searchArtists(term: term)
            .mapError { $0 }
            .map { dto in
                return SearchArtistsDTOMapper.map(dto)
            }
            .eraseToAnyPublisher()
    }
}

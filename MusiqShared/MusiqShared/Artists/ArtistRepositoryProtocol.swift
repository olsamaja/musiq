//
//  ArtistRepository.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 17/01/2021.
//

import Foundation
import Combine

protocol ArtistRepositoryProtocol: RepositoryProtocol {
    func search(with term: String) -> AnyPublisher<[Artist], DataError>
}

struct ArtistLocalRepository: ArtistRepositoryProtocol, CachedDataProtocol {
    
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
    
    func search(with term: String) -> AnyPublisher<[Artist], DataError> {
        return Just(cachedData)
            .mapError { error in
                .parsing(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
}

struct ArtistRemoteRepository: ArtistRepositoryProtocol {
    
    typealias T = Artist
    
    func getAll() -> AnyPublisher<[Artist], DataError> {
        let artists = [Artist]()
        return Just(artists)
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
    
    func search(with term: String) -> AnyPublisher<[Artist], DataError> {
        let artists = [Artist]()
        return Just(artists)
            .mapError { error in
                .parsing(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }

}
